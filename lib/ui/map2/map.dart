import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

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
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  double bottomPaddingOfMap = 0;

  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  @override
  void initState() {
    super.initState();
  }

  void locatePosition() {
    // Add your location logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableBottomSheet(
        minExtent: 150,
        barrierColor: kcPrimaryColor,
        useSafeArea: false,
        curve: Curves.easeIn,
        previewWidget: PreviewWidget(),
        expandedWidget: ExpandedWidget(),
        backgroundWidget: BackgroundWidget(
          controllerGoogleMap: _controllerGoogleMap,
          bottomPaddingOfMap: bottomPaddingOfMap,
          polylineSet: polylineSet,
          markersSet: markersSet,
          circlesSet: circlesSet,
          locatePosition: locatePosition,
        ),
        maxExtent: MediaQuery.of(context).size.height * 0.8,
        onDragging: (pos) {},
      ),
    );
  }
}
