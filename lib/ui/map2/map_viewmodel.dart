import 'dart:async';

import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/app/app.router.dart';
import 'package:campus_compass/services/auth_service.dart';
import 'package:campus_compass/services/pocketbase_service.dart';
import 'package:campus_compass/services/supplement_dataset_service.dart';
import 'package:campus_compass/services/user_details_service.dart';
import 'package:campus_compass/services/user_location_service.dart';
import 'package:campus_compass/ui/map2/assistants/assistantMethods.dart';
import 'package:campus_compass/ui/map2/assistants/requestAssistant.dart';
import 'package:campus_compass/ui/map2/models/address.dart';
import 'package:campus_compass/ui/map2/models/directiondetails.dart';
import 'package:campus_compass/ui/map2/models/placepredictions.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../map/progress_dialog.dart';

class MapViewModel extends ReactiveViewModel {
  final UserDetailsService userDetailsService = locator<UserDetailsService>();
  final NavigationService navigationService = locator<NavigationService>();
  final PocketBaseService pocketBaseService = locator<PocketBaseService>();
  final AuthService _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();
  final SupplementDatasetService _supplementDatasetService =
      locator<SupplementDatasetService>();
  final UserLocationService userLocationService =
      locator<UserLocationService>();

  final DraggableScrollableController sheetController =
      DraggableScrollableController();
  Completer<GoogleMapController> controllerGoogleMap = Completer();
  GoogleMapController? googleMapController;
  Address? initialPosition;
  Address? finalPosition;
  DirectionDetails? tripDetails;
  String? userAddress;
  String? get userAddress1 => userDetailsService.userAddress;
  String? name;
  String? destInfo;
  LatLng? startTripLatLng;
  LatLng? destTripLatLng;
  double? localSelectionLongitude;
  double? localSelectionLatitude;

  double bottomPaddingOfMap = 0;
  bool showProceedButton = false;

  Set<Polyline> polylineSet = {};
  List<LatLng> pLineCoordinates = [];
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  final TextEditingController startLocation = TextEditingController();
  final TextEditingController destLocation = TextEditingController();

  List<PlacePredictions> placePredictionList = [];
  FocusNode? destLocationFocusNode = FocusNode();
  FocusNode? startLocationFocusNode = FocusNode();

  Timer? searchOnStoppedTyping;
  bool isResponseForDestination = false;
  bool isRouteInitiated = false;
  bool isLoading = false;
  bool isLoadingRouteDetails = false;
  bool extendBottomSheet = false;
  bool? _logOutConfirmationResult;

  getUserDetails() async {
    name = await UserSecureStorage.getName();
    print('getting user details');
    userAddress = await UserSecureStorage.getCurrentAddress();
    print(userAddress);

    // if (userAddress == null) {
    //   await userLocationService.locatePosition(
    //     onComplete: () {
    //       notifyListeners();
    //       getUserDetails();
    //     },
    //   );
    // } else {}
    notifyListeners();
  }

  void getSupplementLocations() {
    if (_supplementDatasetService.records.isEmpty) {
      _supplementDatasetService.fetchDataSetRecords();
    } else {
      return;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    LatLng latLatPosition = LatLng(userDetailsService.currentPosition!.latitude,
        userDetailsService.currentPosition!.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 18);
    controllerGoogleMap = Completer(); // Reset the Completer
    controllerGoogleMap
        .complete(controller); // Complete with the new controller
    googleMapController = controller;
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        cameraPosition)); // Update the googleMapController
    notifyListeners();
  }

  void logOut() {
    // Navigate back to the sign-in page
    navigationService.clearStackAndShow(Routes.signInPage);
    // Clear the auth store
    UserSecureStorage.clearUserData();
    pocketBaseService.pb.authStore.clear();
    // userLocationService.logout();
  }

  void resetMap() {
    userDetailsService.getUserDetails();
    //userLocationService.locatePosition();
  }

  void onChangeHandler(String value, bool isDestination) {
    sheetController.animateTo(
      0.8,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );

    isResponseForDestination = isDestination;
    extendBottomSheet = true;
    showProceedButton = false;
    isLoading = true;
    notifyListeners();

    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping!.cancel();
    }

    searchOnStoppedTyping = Timer(
      const Duration(seconds: 1),
      () => findPlace(value, isDestination),
    );

    notifyListeners();
  }

  void useCurrentLocation() {
    if (userDetailsService.userAddress != null) {
      startLocation.text = userDetailsService.userAddress!;
      Address address = Address();
      address.placeName = userDetailsService.userAddress;
      address.latitude = userDetailsService.currentPosition!.latitude;
      address.longitude = userDetailsService.currentPosition!.longitude;
      initialPosition = address;
    } else {
      userDetailsService.getUserDetails();
      userLocationService.locatePosition();
      startLocation.text = userDetailsService.userAddress!;
    }
    notifyListeners();
  }

  bool get isAnyFieldFocused =>
      startLocationFocusNode!.hasFocus || destLocationFocusNode!.hasFocus;

  MapViewModel() {
    startLocationFocusNode!.addListener(_onFocusChange);
    destLocationFocusNode!.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    notifyListeners();
  }

  restartMapControllerService() {
    print("RESTARTING MAP CONTROLLER SERVICES");
    userLocationService.locatePosition();
  }

  void initiateSupplementCoordinates(
    double localSelectionLongitude,
    double localSelectionLatitude,
    String localSelectionPlaceName,
  ) async {
    notifyListeners();
    sheetController.animateTo(
      0.4,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
    Address address = Address();
    address.placeName = localSelectionPlaceName;
    address.latitude = localSelectionLatitude;
    address.longitude = localSelectionLongitude;

    if (isResponseForDestination) {
      finalPosition = address;
    } else {
      initialPosition = address;
    }
  }

  void getPlaceAddressDetails(
    String placeId,
    context, {
    required bool isDestination,
  }) async {
    notifyListeners();
    sheetController.animateTo(
      0.4,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
    final placeDetailsUrl = Uri.tryParse(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyCcgEzOMRr0OeiQ_L9Hp7ycMKi4v3D-oWs");

    var res = await RequestAssistant.getRequest(placeDetailsUrl);

    // Navigator.pop(context);

    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      if (isResponseForDestination) {
        finalPosition = address;
      } else {
        initialPosition = address;
      }

      // Provider.of<AppData>(context, listen: false)
      //     .updatedestLocationAddress(address);
      print("This is place:: ");
      print(address.placeName);
      // getPlaceDirection(initialPosition, finalPosition);

      notifyListeners();
    }
  }

  void findPlace(String placeName, bool isDestination) async {
    setBusy(true);
    notifyListeners();

    List<RecordModel> locationDataset = _supplementDatasetService.records;
    List<Map<String, dynamic>> filteredPlaceList = [];

    if (placeName.isNotEmpty) {
      // Filter local dataset based on place name
      for (var record in locationDataset) {
        if (record.data['place_name']
            .toLowerCase()
            .contains(placeName.toLowerCase())) {
          filteredPlaceList.add(record.data);
        }
      }

      // Parse filteredPlaceList to fit the PlacePredictions class
      List<PlacePredictions> localPlacePredictions =
          filteredPlaceList.map((record) {
        return PlacePredictions(
          main_text: record['place_name'],
          secondary_text: record['place_type'],
          place_id: record['id'].toString(),
          image: record['image'],
          isSupplement: record['isSupplement'],
          coordinates: (record['coordinates'] as List<dynamic>)
              .map((item) => item as double)
              .toList(),
        );
      }).toList();

      // Immediately display local predictions
      placePredictionList = [...localPlacePredictions];
      isLoading = false;
      notifyListeners(); // Notify listeners to update the UI with local results

      // Fetch Google Places API results asynchronously
      if (placeName.length > 1) {
        final autoCompleteUrl = Uri.tryParse(
            "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&location=7.2500,5.1950&radius=1000&types=geocode&key=AIzaSyCcgEzOMRr0OeiQ_L9Hp7ycMKi4v3D-oWs");

        var res = await RequestAssistant.getRequest(autoCompleteUrl);
        if (res == "failed") {
          setBusy(false);
          isLoading = false;
          notifyListeners();
          return;
        }

        if (res["status"] == "OK") {
          final predictions = res["predictions"];
          final List<PlacePredictions> googlePlacePredictions = [];

          // For each Google Place prediction, get the place details to retrieve coordinates
          for (var prediction in predictions) {
            String placeId = prediction['place_id'];

            // Fetch place details to get coordinates
            final placeDetailsUrl = Uri.tryParse(
                "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=AIzaSyCcgEzOMRr0OeiQ_L9Hp7ycMKi4v3D-oWs");

            var detailsRes = await RequestAssistant.getRequest(placeDetailsUrl);
            if (detailsRes != "failed" && detailsRes["status"] == "OK") {
              var location = detailsRes["result"]["geometry"]["location"];
              double latitude = location["lat"];
              double longitude = location["lng"];

              // Check if the coordinates are within Akure bounds
              if (_isWithinAkureBounds(latitude, longitude)) {
                googlePlacePredictions.add(PlacePredictions(
                  main_text: prediction['structured_formatting']['main_text'],
                  secondary_text: prediction['structured_formatting']
                      ['secondary_text'],
                  place_id: placeId,
                  coordinates: [latitude, longitude],
                ));
              }
            }
          }

          // Add Google Places predictions to the existing local predictions
          placePredictionList = [
            ...placePredictionList, // Keep the local predictions
            ...googlePlacePredictions, // Add Google Places results
          ];
          notifyListeners(); // Notify listeners to update the UI with combined results
        }
      }
    } else {
      // If placeName is empty, clear the predictions list
      placePredictionList = [];
      isLoading = false;
    }

    setBusy(false);
    isLoading = false;
    notifyListeners();
  }

// Helper function to check if coordinates are within Akure bounds
  bool _isWithinAkureBounds(double latitude, double longitude) {
    const double northBoundary = 7.3400;
    const double southBoundary = 7.1700;
    const double eastBoundary = 5.2500;
    const double westBoundary = 5.0900;

    return (latitude <= northBoundary && latitude >= southBoundary) &&
        (longitude <= eastBoundary && longitude >= westBoundary);
  }

  Future<void> getPlaceDirection(
    initialPosition,
    finalPosition,
  ) async {
    isLoadingRouteDetails = true;
    notifyListeners();
    var startLatLng =
        LatLng(initialPosition!.latitude, initialPosition.longitude);
    startTripLatLng = startLatLng;

    var destLatLng = LatLng(finalPosition!.latitude, finalPosition.longitude);
    destTripLatLng = destLatLng;

    var details =
        await AssistantMethods.obtainDirectionDetails(startLatLng, destLatLng);
    tripDetails = details;

    // Navigator.pop(context);

    print("This is Encoded Points :: ");
    print(details?.encodedPoints);
    print(details);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details!.encodedPoints!);

    pLineCoordinates.clear();

    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates.add(
          LatLng(pointLatLng.latitude, pointLatLng.longitude),
        );
      });
    }

    polylineSet.clear();

    Polyline polyline = Polyline(
      color: Colors.purple,
      polylineId: PolylineId("PolylineID"),
      jointType: JointType.mitered,
      points: pLineCoordinates,
      width: 8,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );

    polylineSet.add(polyline);

    LatLngBounds latLngBounds;
    if (startLatLng.latitude > destLatLng.latitude &&
        startLatLng.longitude > destLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: destLatLng, northeast: startLatLng);
    } else if (startLatLng.longitude > destLatLng.longitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(startLatLng.latitude, destLatLng.longitude),
        northeast: LatLng(destLatLng.latitude, startLatLng.longitude),
      );
    } else if (startLatLng.latitude > destLatLng.latitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(destLatLng.latitude, startLatLng.longitude),
        northeast: LatLng(startLatLng.latitude, destLatLng.longitude),
      );
    } else {
      latLngBounds =
          LatLngBounds(southwest: startLatLng, northeast: destLatLng);
    }
    googleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 100));

    Marker startLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      infoWindow: InfoWindow(
          title: initialPosition!.placeName, snippet: "Start Location"),
      position: startLatLng,
      markerId: MarkerId("startId"),
    );

    Marker destLocMarker = Marker(
      flat: false,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(
          title: finalPosition!.placeName, snippet: "Destination Location"),
      position: destLatLng,
      markerId: MarkerId("destId"),
    );

    markersSet.add(startLocMarker);
    markersSet.add(destLocMarker);
    notifyListeners();

    Circle startLocCircle = Circle(
      fillColor: Colors.white,
      center: startLatLng,
      radius: 10,
      strokeWidth: 4,
      strokeColor: Colors.purpleAccent,
      circleId: CircleId("StartId"),
    );

    Circle destLocCircle = Circle(
      fillColor: Colors.white,
      center: destLatLng,
      radius: 10,
      strokeWidth: 4,
      strokeColor: Color.fromARGB(255, 0, 0, 0),
      circleId: CircleId("DestId"),
    );

    circlesSet.add(startLocCircle);
    circlesSet.add(destLocCircle);
    notifyListeners();
  }

  Future<void> showLogOutConfirmationDialog() async {
    var response = await _dialogService.showConfirmationDialog(
      title: 'Log Out',
      description: 'Are you sure you want to log out?',
      confirmationTitle: 'Yes',
      confirmationTitleColor: kcPrimaryColor,
      cancelTitle: 'Cancel',
      barrierDismissible: true,
    );

    _logOutConfirmationResult = response?.confirmed;
    if (_logOutConfirmationResult == true) {
      logOut();
    } else {
      return;
    }

    notifyListeners();
  }

  // @override
  // void dispose() {
  //   userLocationService.dispose();
  //   startLocation.dispose();
  //   destLocation.dispose();
  //   userLocationService.dispose();
  //   print('DISPOSING');
  //   super.dispose();
  // }
}
