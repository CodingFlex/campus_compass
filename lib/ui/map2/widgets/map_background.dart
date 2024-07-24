// background_widget.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BackgroundWidget extends StatelessWidget {
  final Completer<GoogleMapController> controllerGoogleMap;
  final double bottomPaddingOfMap;
  final Set<Polyline> polylineSet;
  final Set<Marker> markersSet;
  final Set<Circle> circlesSet;
  final Function locatePosition;

  BackgroundWidget({
    required this.controllerGoogleMap,
    required this.bottomPaddingOfMap,
    required this.polylineSet,
    required this.markersSet,
    required this.circlesSet,
    required this.locatePosition,
  });

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
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
        controllerGoogleMap.complete(controller);
        locatePosition();
      },
      compassEnabled: true,
    );
  }
}
