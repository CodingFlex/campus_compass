import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../DataHandler/appData.dart';
import '../models/address.dart';
import '../models/directiondetails.dart';
import 'requestAssistant.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String st1, st2;
    final url = Uri.tryParse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyCcgEzOMRr0OeiQ_L9Hp7ycMKi4v3D-oWs");

    var response = await RequestAssistant.getRequest(url);

    if (response != "failed") {
      //placeAddress = response["results"][0]["formatted_address"];
      st1 = response["results"][0]["address_components"][0]["long_name"];
      st2 = response["results"][0]["address_components"][1]["long_name"];
      placeAddress = st1 + ", " + st2;

      Address userStartAddress = new Address(
          latitude: position.latitude,
          longitude: position.longitude,
          placeName: placeAddress,
          placeId: '');
      userStartAddress.longitude = position.longitude;
      userStartAddress.latitude = position.latitude;
      userStartAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updateStartAddress(userStartAddress);
    }
    print('placeAddress: $placeAddress');

    return placeAddress;
  }

  static Future<DirectionDetails?> obtainDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    final directionUrl = Uri.tryParse(
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude}, ${finalPosition.longitude}&key=AIzaSyCcgEzOMRr0OeiQ_L9Hp7ycMKi4v3D-oWs");

    var res = await RequestAssistant.getRequest(directionUrl);

    if (res == "failed") {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints =
        res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText =
        res["routes"][0]["legs"][0]["distance"]["text"];

    directionDetails.distanceValue =
        res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText =
        res["routes"][0]["legs"][0]["duration"]["text"];

    directionDetails.durationValue =
        res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }
}
