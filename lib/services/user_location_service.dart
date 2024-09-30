import 'dart:async';

import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/services/user_details_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationService {
  final UserDetailsService userDetailsService = locator<UserDetailsService>();
  Completer<GoogleMapController> controllerGoogleMap = Completer();

  GoogleMapController? googleMapController;
  String? address;
  Position? currentPosition;

  UserLocationService();

  Future<void> locatePosition() async {
    LatLng latLatPosition = LatLng(userDetailsService.currentPosition!.latitude,
        userDetailsService.currentPosition!.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 18);

    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void dispose() {
    googleMapController?.dispose();
  }
}
