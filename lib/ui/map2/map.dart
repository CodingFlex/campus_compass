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

import 'widgets/map_preview.dart';

class MapScreen2 extends StatefulWidget {
  @override
  State<MapScreen2> createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {
  double bottomPaddingOfMap = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      viewModelBuilder: () => MapViewModel(),
      onViewModelReady: (model) async {
        await model.getUserDetails();
      },
      builder: (context, model, child) => Scaffold(
        body: DraggableBottomSheet(
          minExtent: model.isAnyFieldFocused
              ? MediaQuery.of(context).size.height * 0.9
              : 300,
          useSafeArea: false,
          curve: Curves.easeIn,
          previewWidget: PreviewWidget(
            isExpanded: false,
            model: model,
          ),
          expandedWidget: PreviewWidget(
            isExpanded: true,
            model: model,
          ),
          backgroundWidget: BackgroundWidget(
            controllerGoogleMap: model.controllerGoogleMap,
            bottomPaddingOfMap: bottomPaddingOfMap,
            polylineSet: model.polylineSet,
            markersSet: model.markersSet,
            circlesSet: model.circlesSet,
          ),
          maxExtent: MediaQuery.of(context).size.height * 0.9,
          onDragging: (pos) {},
        ),
      ),
    );
  }
}
