import 'dart:async';

import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/services/user_details_service.dart';
import 'package:campus_compass/ui/map2/assistants/assistantMethods.dart';
import 'package:campus_compass/ui/map2/models/address.dart';
import 'package:campus_compass/utils/user_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationService {
  final UserDetailsService userDetailsService = locator<UserDetailsService>();
  final Completer<GoogleMapController> controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  GoogleMapController? googleMapController;
  String? address;
  Position? currentPosition;

  UserLocationService();

  Future<void> getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    UserSecureStorage.setLongitude(position.longitude);
    UserSecureStorage.setLatitude(position.latitude);
  }

  Future<void> locatePosition() async {
    LatLng latLatPosition = LatLng(userDetailsService.currentPosition!.latitude,
        userDetailsService.currentPosition!.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 18);

    googleMapController = await controllerGoogleMap.future;
    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(
      userDetailsService.currentPosition!,
    );

    UserSecureStorage.setCurrentAddress(address);
    print("IM GETTING HERE");
    print("This is your Address :: " + address);
  }
}
