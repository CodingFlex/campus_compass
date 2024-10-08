import 'package:campus_compass/ui/map2/assistants/assistantMethods.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/user_secure_storage.dart';

class UserDetailsService {
  String? name;
  String? userAddress;

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
    UserSecureStorage.setLongitude(position.longitude);
    UserSecureStorage.setLatitude(position.latitude);
    String address = await AssistantMethods.searchCoordinateAddress(
      currentPosition!,
    );
    UserSecureStorage.setCurrentAddress(address);
    name = await UserSecureStorage.getName();
    token = await UserSecureStorage.getAccessKey();
    userAddress = address;
  }

  void getSecureStorageDetails() async {
    name = await UserSecureStorage.getName();
    token = await UserSecureStorage.getAccessKey();
  }
}
