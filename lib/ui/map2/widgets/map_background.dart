// background_widget.dart
import 'dart:async';
import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/constants/assets.dart';
import 'package:campus_compass/services/user_location_service.dart';
import 'package:campus_compass/ui/map2/map_viewmodel.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/shared/text_styles.dart';

class BackgroundWidget extends StatelessWidget {
  final Completer<GoogleMapController> controllerGoogleMap;
  final double bottomPaddingOfMap;
  final Set<Polyline> polylineSet;
  final Set<Marker> markersSet;
  final Set<Circle> circlesSet;

  BackgroundWidget({
    required this.controllerGoogleMap,
    required this.bottomPaddingOfMap,
    required this.polylineSet,
    required this.markersSet,
    required this.circlesSet,
  });

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.307042, 5.1397549),
    zoom: 100,
  );

  @override
  Widget build(BuildContext context) {
    final _locatePosition = locator<UserLocationService>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Adjust padding as needed
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              border: Border.all(color: Colors.black, width: .5),
              // Border color
              borderRadius:
                  BorderRadius.circular(8.0), // Rounded corners (optional)
            ),
            padding:
                EdgeInsets.all(8.0), // Space between the icon and the border
            child: Icon(
              Icons.menu_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        actions: const <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person_2_outlined,
                color: Colors.black,
              ),
              // backgroundImage: AssetImage(Assets.splash),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GoogleMap(
        padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        polylines: polylineSet,
        markers: markersSet,
        circles: circlesSet,
        onMapCreated: (GoogleMapController controller) {
          _locatePosition.controllerGoogleMap.complete(controller);
        },
        compassEnabled: true,
      ),
    );
  }
}
