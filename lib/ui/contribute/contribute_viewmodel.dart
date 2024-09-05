import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/services/contribution_service.dart';
import 'package:campus_compass/ui/map2/assistants/assistantMethods.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class ContributeViewModel extends BaseViewModel {
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController placeTypeController = TextEditingController();
  final ContributionService _contributionService =
      locator<ContributionService>();
  Position? currentPosition;
  String? currentAddress;
  bool contributeBusy = false;
  Future<void> fetchLocation() async {
    setBusy(true);
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      currentPosition = position;
      String address = await AssistantMethods.searchCoordinateAddress(
        currentPosition!,
      );
      currentAddress = address;
      LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('Error fetching location: $e');
      setError(e);
    }
    setBusy(false);
  }

  void sendContribution() async {
    contributeBusy = true;
    notifyListeners();
    await _contributionService.sendContribution(
      placeNameController.text,
      placeTypeController.text,
      currentPosition!.longitude,
      currentPosition!.latitude,
    );
    contributeBusy = false;
    notifyListeners();
  }
}
