import 'package:campus_compass/ui/map2/assistants/assistantMethods.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../../app/app.locator.dart';
import '../../services/user_details_service.dart';
import '../../utils/widgets/box_input_field.dart';
import 'map_viewmodel.dart';

import 'widgets/map_background.dart';
import 'widgets/map_expanded.dart';
import 'widgets/map_preview.dart';

class MapScreen2 extends StatefulWidget {
  @override
  State<MapScreen2> createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(),
    );
  }
}

class MapWidget extends StatefulWidget {
  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final UserDetailsService _userDetailsService = locator<UserDetailsService>();
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? googleMapController;
  String? address;

  double bottomPaddingOfMap = 0;

  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  @override
  void initState() {
    super.initState();
  }

  void locatePosition() async {
    LatLng latLatPosition = LatLng(
        _userDetailsService.currentPosition!.latitude,
        _userDetailsService.currentPosition!.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 18);

    googleMapController = await _controllerGoogleMap.future;
    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(
        _userDetailsService.currentPosition!, context);
    print("This is your Address :: " + address);

    setState(() {
      this.address = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableBottomSheet(
        minExtent: 195,
        useSafeArea: false,
        curve: Curves.easeIn,
        previewWidget: PreviewWidget(isExpanded: false, address: address),
        expandedWidget: PreviewWidget(isExpanded: true, address: address),
        backgroundWidget: BackgroundWidget(
          controllerGoogleMap: _controllerGoogleMap,
          bottomPaddingOfMap: bottomPaddingOfMap,
          polylineSet: polylineSet,
          markersSet: markersSet,
          circlesSet: circlesSet,
          locatePosition: locatePosition,
          currentPosition: _userDetailsService.currentPosition,
        ),
        maxExtent: MediaQuery.of(context).size.height * 0.9,
        onDragging: (pos) {},
      ),
    );
  }
}
