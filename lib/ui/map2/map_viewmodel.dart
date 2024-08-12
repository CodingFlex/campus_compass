import 'dart:async';

import 'package:campus_compass/ui/map2/assistants/requestAssistant.dart';
import 'package:campus_compass/ui/map2/models/address.dart';
import 'package:campus_compass/ui/map2/models/placepredictions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../map/progress_dialog.dart';

class MapViewModel extends ReactiveViewModel {
  final TextEditingController startLocation = TextEditingController();
  final TextEditingController destLocation = TextEditingController();

  List<PlacePredictions> placePredictionList = [];
  FocusNode? destLocationFocusNode = FocusNode();
  FocusNode? startLocationFocusNode = FocusNode();

  Timer? searchOnStoppedTyping;
  bool isResponseForDestination = false;
  bool isLoading = false;

  void onChangeHandler(String value, bool isDestination) {
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

  bool get isAnyFieldFocused =>
      startLocationFocusNode!.hasFocus || destLocationFocusNode!.hasFocus;

  MapViewModel() {
    startLocationFocusNode!.addListener(_onFocusChange);
    destLocationFocusNode!.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    notifyListeners();
  }

  void getPlaceAddressDetails(String placeId, context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(
          message: "Fetching route, please wait...",
        );
      },
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

      // Provider.of<AppData>(context, listen: false)
      //     .updatedestLocationAddress(address);
      // print("This is destination :: ");
      // print(address.placeName);

      Navigator.pop(context, "obtainDirection");
      notifyListeners();
    }
  }

  findPlace(String placeName, bool isDestination) async {
    setBusy(true);
    notifyListeners();

    isResponseForDestination = isDestination;

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
}
