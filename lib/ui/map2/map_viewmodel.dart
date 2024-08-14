import 'dart:async';

import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/services/user_details_service.dart';
import 'package:campus_compass/services/user_location_service.dart';
import 'package:campus_compass/ui/map2/assistants/assistantMethods.dart';
import 'package:campus_compass/ui/map2/assistants/requestAssistant.dart';
import 'package:campus_compass/ui/map2/models/address.dart';
import 'package:campus_compass/ui/map2/models/placepredictions.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../map/progress_dialog.dart';

class MapViewModel extends ReactiveViewModel {
  final UserDetailsService userDetailsService = locator<UserDetailsService>();
  final UserLocationService userLocationService =
      locator<UserLocationService>();
  final Completer<GoogleMapController> controllerGoogleMap = Completer();

  GoogleMapController? googleMapController;

  Address? initialPosition;
  Address? finalPosition;

  String? get userAddress => userDetailsService.userAddress;
  String? get name => userDetailsService.name;

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

  void onChangeHandler(String value, bool isDestination) {
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
      userLocationService.getUserLocation();
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
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return ProgressDialog(
    //       message: "Fetching route, please wait...",
    //     );
    //   },
    // );

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

    print(isResponseForDestination);

    if (placeName.length > 1) {
      final autoCompleteUrl = Uri.tryParse(
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&location=7.3070,5.1398&radius=100&types=geocode&key=AIzaSyCcgEzOMRr0OeiQ_L9Hp7ycMKi4v3D-oWs");

      var res = await RequestAssistant.getRequest(autoCompleteUrl);
      if (res == "failed") {
        return;
      }
      if (res["status"] == "OK") {
        var predictions = res["predictions"];

        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();

        placePredictionList = placesList;
        print(placePredictionList);

        setBusy(false);
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> getPlaceDirection(
    initialPosition,
    finalPosition,
  ) async {
    var startLatLng =
        LatLng(initialPosition!.latitude, initialPosition.longitude);

    var destLatLng = LatLng(finalPosition!.latitude, finalPosition.longitude);

    var details =
        await AssistantMethods.obtainDirectionDetails(startLatLng, destLatLng);

    // Navigator.pop(context);

    print("This is Encoded Points :: ");
    print(details?.encodedPoints);

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
      color: Colors.amber,
      polylineId: PolylineId("PolylineID"),
      jointType: JointType.round,
      points: pLineCoordinates,
      width: 5,
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
    userLocationService.newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker startLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow:
          InfoWindow(title: initialPosition!.placeName, snippet: "My Location"),
      position: startLatLng,
      markerId: MarkerId("startId"),
    );

    Marker destLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
          title: finalPosition!.placeName, snippet: "My Destination"),
      position: destLatLng,
      markerId: MarkerId("destId"),
    );

    markersSet.add(startLocMarker);
    markersSet.add(destLocMarker);

    Circle startLocCircle = Circle(
      fillColor: Colors.blueGrey,
      center: startLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueGrey,
      circleId: CircleId("StartId"),
    );

    Circle destLocCircle = Circle(
      fillColor: kcPrimaryColor,
      center: destLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.pinkAccent,
      circleId: CircleId("DestId"),
    );

    circlesSet.add(startLocCircle);
    circlesSet.add(destLocCircle);
  }
}
