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
    print('MAP SETUP ');
  }

  void onMapCreated(GoogleMapController controller) {
    controllerGoogleMap = Completer(); // Reset the Completer
    controllerGoogleMap
        .complete(controller); // Complete with the new controller
    googleMapController = controller; // Update the googleMapController
  }

  void dispose() {
    googleMapController?.dispose();
  }
}
