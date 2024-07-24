import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import 'package:geolocator/geolocator.dart';

import 'DataHandler/appData.dart';
import 'assistants/assistantMethods.dart';
import 'divider.dart';
import 'progress_dialog.dart';
import 'searchscreen.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.only(top: 15.0),
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          color: Colors.blueGrey,
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/flex_logo.png',
                height: 20,
                width: 50,
              ),
              Text(
                'FUTA Map',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 18.0,
              backgroundImage: AssetImage('assets/images/flex_logo.png'),
            ),
          ),
        ],
      ),
      body: MapWidget(),
    );
  }
}

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<LatLng> pLineCoordinates = [];

  Set<Polyline> polylineSet = {};

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your Address :: " + address);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.3050, 5.1300),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          polylines: polylineSet,
          markers: markersSet,
          circles: circlesSet,
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;

            setState(() {
              bottomPaddingOfMap = 300.0;
            });

            locatePosition();
          },
          compassEnabled: true,
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                )
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6.0),
                  Text(
                    "Hey!",
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Where to?",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () async {
                      var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ),
                      );

                      if (res == "obtainDirection") {
                        await getPlaceDirection();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
                          Icon(Icons.search, color: Colors.amber),
                          SizedBox(width: 10.0),
                          Text("Search Destination"),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 12.0,
                        width: 7.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              Provider.of<AppData>(context).startLocation !=
                                      null
                                  ? Provider.of<AppData>(context)
                                      .startLocation!
                                      .placeName
                                      .toString()
                                  : "Add start",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            "Your current location",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  DividerWidget(),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(Icons.work, color: Colors.grey),
                      SizedBox(
                        height: 12.0,
                        width: 7.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add destination",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            "Where you want to go",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getPlaceDirection() async {
    var initialPos = Provider.of<AppData>(context, listen: false).startLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).destLocation;

    var startLatLng = LatLng(initialPos!.latitude!, initialPos.longitude!);

    var destLatLng = LatLng(finalPos!.latitude!, finalPos.longitude!);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProgressDialog(
          message: "Almost there",
        );
      },
    );

    var details =
        await AssistantMethods.obtainDirectionDetails(startLatLng, destLatLng);

    Navigator.pop(context);

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

    setState(() {
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
    });

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
    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker startLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow:
          InfoWindow(title: initialPos.placeName, snippet: "My Location"),
      position: startLatLng,
      markerId: MarkerId("startId"),
    );

    Marker destLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow:
          InfoWindow(title: finalPos.placeName, snippet: "My Destination"),
      position: destLatLng,
      markerId: MarkerId("destId"),
    );

    setState(() {
      markersSet.add(startLocMarker);
      markersSet.add(destLocMarker);
    });

    Circle startLocCircle = Circle(
      fillColor: Colors.blueGrey,
      center: startLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueGrey,
      circleId: CircleId("StartId"),
    );

    Circle destLocCircle = Circle(
      fillColor: Colors.pink,
      center: destLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.pinkAccent,
      circleId: CircleId("DestId"),
    );

    setState(() {
      circlesSet.add(startLocCircle);
      circlesSet.add(destLocCircle);
    });
  }
}
