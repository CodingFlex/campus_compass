import 'package:campus_compass/ui/map2/assistants/assistantMethods.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../app/app.locator.dart';
import '../utils/user_secure_storage.dart';

class UserDetailsService {
  String? name;
  String? otherNames;
  String? currentLevel;
  String? idCard;
  String? matricnumber;
  String? faculty;
  Position? currentPosition;
  String? token;

  //final SessionManager sessionManager = locator<SessionManager>();
  //final FetchDataService _fetchService = locator<FetchDataService>();
  //final NetworkService _networkService = locator<NetworkService>();

  UserDetailsService();

  Future<void> getUserDetails() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    name = await UserSecureStorage.getName();

    // CameraPosition cameraPosition =
    //     new CameraPosition(target: latLatPosition, zoom: 14);
    // newGoogleMapController
    //     .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // String address =
    //     await AssistantMethods.searchCoordinateAddress(position, context);
    // print("This is your Address :: " + address);
  }
}
