import 'package:campus_compass/services/user_location_service.dart';
import 'package:campus_compass/ui/contribute/contribute.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import 'map_viewmodel.dart';


import 'widgets/map_preview.dart';

class MapScreen2 extends StatefulWidget {
  @override
  State<MapScreen2> createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.307042, 5.1397549),
    zoom: 100,
  );

  @override
  Widget build(BuildContext context) {
    final _locatePosition = locator<UserLocationService>();
    final NavigationService navigationService = locator<NavigationService>();
    return ViewModelBuilder<MapViewModel>.reactive(
      viewModelBuilder: () => MapViewModel(),
      onViewModelReady: (model) async {
        await model.getUserDetails();
        model.getSupplementLocations();
        await model.restartMapControllerService();
      },
      builder: (context, model, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5.0), // Adjust padding as needed
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: kcPrimaryColor, // adjust the color as needed
                  width: 2, // adjust the width as needed
                ),
                borderRadius:
                    BorderRadius.circular(10), // adjust the radius as needed
              ),
              child: Center(
                child: PopupMenuButton<int>(
                  elevation: 5,
                  color: Colors.white,
                  position: PopupMenuPosition.under,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // adjust the radius as needed
                    side: BorderSide(
                      color: kcPrimaryColor, // adjust the color as needed
                      width: 2, // adjust the width as needed
                    ),
                  ),
                  icon: Icon(
                    Icons.menu_outlined,
                    color: Colors.black,
                    size: 25,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.homeAlt,
                            size: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Home', style: bodyStyle),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.signOut,
                            size: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Logout', style: bodyStyle),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.plus,
                            size: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Contribute', style: bodyStyle),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen2(),
                        ),
                      );
                      model.resetMap();
                    } else if (value == 2) {
                      model.showLogOutConfirmationDialog();
                    } else if (value == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContributeView(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            buildingsEnabled: true,
            polylines: model.polylineSet,
            markers: model.markersSet,
            circles: model.circlesSet,
            onMapCreated: model.onMapCreated,
            compassEnabled: true,
          ),
          DraggableScrollableSheet(
            controller: model.sheetController,
            snap: true,
            initialChildSize: 0.3,
            maxChildSize: !model.isRouteInitiated ? 0.8 : 0.3,
            minChildSize: 0.3,
            builder: (BuildContext context, scrollController) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: kcPrimaryColor, // adjust the color as needed
                      width: 2, // adjust the width as needed
                    ),
                    left: BorderSide(
                      color: kcPrimaryColor, // adjust the color as needed
                      width: 2, // adjust the width as needed
                    ),
                    right: BorderSide(
                      color: kcPrimaryColor, // adjust the color as needed
                      width: 2, // adjust the width as needed
                    ),
                  ),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverFillRemaining(
                        hasScrollBody:
                            model.sheetController == 0.3 ? false : true,
                        child: PreviewWidget(model: model)),
                  ],
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
