// background_widget.dart
import 'dart:async';
import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/app/app.router.dart';
import 'package:campus_compass/constants/assets.dart';
import 'package:campus_compass/services/user_location_service.dart';
import 'package:campus_compass/ui/map2/map.dart';
import 'package:campus_compass/ui/map2/map_viewmodel.dart';
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../utils/shared/text_styles.dart';

class BackgroundWidget extends StatelessWidget {
  final double bottomPaddingOfMap;
  final MapViewModel model;

  BackgroundWidget({
    required this.bottomPaddingOfMap,
    required this.model,
  });

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.307042, 5.1397549),
    zoom: 100,
  );

  @override
  Widget build(BuildContext context) {
    final _locatePosition = locator<UserLocationService>();
    final NavigationService navigationService = locator<NavigationService>();
    return GestureDetector(
      child: Scaffold(
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
                    }
                  },
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GoogleMap(
          padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
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
      ),
    );
  }
}
