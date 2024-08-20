import 'dart:async';

import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/services/auth_service.dart';
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

import '../map/progress_dialog.dart';

class MapViewModel extends ReactiveViewModel {
  final UserDetailsService userDetailsService = locator<UserDetailsService>();
  final AuthService _authService = locator<AuthService>();
  final SupplementDatasetService _supplementDatasetService =
      locator<SupplementDatasetService>();
  final UserLocationService userLocationService =
      locator<UserLocationService>();
  final Completer<GoogleMapController> controllerGoogleMap = Completer();
  GoogleMapController? googleMapController;
  Address? initialPosition;
  Address? finalPosition;
  DirectionDetails? tripDetails;
  String? userAddress;
  String? get userAddress1 => userDetailsService.userAddress;
  String? name;
  LatLng? startTripLatLng;
  LatLng? destTripLatLng;

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
  bool isLoading = false;
  bool isLoadingRouteDetails = false;
  bool extendBottomSheet = false;

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

  void onChangeHandler(String value, bool isDestination) {
    extendBottomSheet = true;
    showProceedButton = false;
    isLoading = true;
    isResponseForDestination = isDestination;
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
    } else {
      userDetailsService.getUserDetails();
      userLocationService.locatePosition();
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

  void getPlaceAddressDetails(String placeId, context,
      {required bool isDestination}) async {
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

  findPlace(String placeName, bool isDestination) async {
    setBusy(true);
    notifyListeners();

    List<RecordModel> locationDataset = _supplementDatasetService.records;
    List<Map<String, dynamic>> filteredPlaceList = [];

    if (placeName.isNotEmpty) {
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
        );
      }).toList();

      // Combine localPlacePredictions with Google Places API results
      if (placeName.length > 1) {
        final autoCompleteUrl = Uri.tryParse(
            "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&location=7.3070,5.1398&radius=100&types=geocode&key=AIzaSyCcgEzOMRr0OeiQ_L9Hp7ycMKi4v3D-oWs");

        var res = await RequestAssistant.getRequest(autoCompleteUrl);
        if (res == "failed") {
          return;
        }
        if (res["status"] == "OK") {
          final predictions = res["predictions"];
          print(predictions);
          final googlePlacePredictions = (predictions as List)
              .map((e) => PlacePredictions.fromJson(e))
              .toList();
          placePredictionList = [
            ...localPlacePredictions,
            ...googlePlacePredictions,
          ];
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

  Future<void> getPlaceDirection(
    initialPosition,
    finalPosition,
  ) async {
    isLoadingRouteDetails = true;
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
    userLocationService.googleMapController!
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
      fillColor: Colors.purple,
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
      strokeColor: Color.fromARGB(255, 8, 40, 21),
      circleId: CircleId("DestId"),
    );

    circlesSet.add(startLocCircle);
    circlesSet.add(destLocCircle);
    notifyListeners();
  }
}
