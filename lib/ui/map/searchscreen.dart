import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DataHandler/appData.dart';
import 'assistants/requestAssistant.dart';
import 'divider.dart';
import 'models/address.dart';
import 'models/placepredictions.dart';
import 'progress_dialog.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController startTextEditingController = TextEditingController();
  TextEditingController destTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];

  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).startLocation?.placeName ?? "";
    startTextEditingController.text = placeAddress;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 25.0,
                top: 25.0,
                right: 25.0,
                bottom: 20.0,
              ),
              child: Column(
                children: [
                  SizedBox(height: 5.0),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      Center(
                        child: Text(
                          "Set Destination",
                          style: TextStyle(
                              fontSize: 18.0, fontFamily: "Brand-bold"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20.0,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: startTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Current location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                  left: 11.0,
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20.0,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              onChanged: (value) {
                                findPlace(value);
                              },
                              controller: destTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Where to?",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                  left: 11.0,
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          (placePredictionList.length > 0)
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                        placePredictions: placePredictionList[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        DividerWidget(),
                    itemCount: placePredictionList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void findPlace(String placeName) async {
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
        setState(() {
          placePredictionList = placesList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;

  PredictionTile({Key? key, required this.placePredictions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.all(0.0)),
      onPressed: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0),
            Row(
              children: [
                Icon(
                  Icons.add_location,
                  color: Colors.red,
                ),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePredictions.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
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

    Navigator.pop(context);

    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false)
          .updatedestLocationAddress(address);
      print("This is destination :: ");
      print(address.placeName);

      Navigator.pop(context, "obtainDirection");
    }
  }
}
