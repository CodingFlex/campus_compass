import 'dart:async';

import 'package:campus_compass/services/user_location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:toastification/toastification.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';


import 'services/user_details_service.dart';

import 'ui/map2/map_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GMService.initializeMapRenderer();
  await dotenv.load();
  setupLocator();
  initializeLocationAndSave();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MyApp(),
  );
}

initializeLocationAndSave() async {
  final UserDetailsService _userDetailsService = locator<UserDetailsService>();
  final UserLocationService _userLocationService =
      locator<UserLocationService>();
  final _mapviewmodel = locator<MapViewModel>();
  // Ensure all permissions are collected for Locations

  bool? _serviceEnabled;

  LocationPermission _permission;

  _serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!_serviceEnabled) {}

  _permission = await Geolocator.checkPermission();

  if (_permission == LocationPermission.denied) {
    _permission = await Geolocator.requestPermission();
  }
  await _userDetailsService.getUserDetails();
  await _userLocationService.locatePosition();
}

Future<void> initializeApp() async {
  await initializeLocationAndSave();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return ToastificationWrapper(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: StackedService.navigatorKey,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          initialRoute: Routes.splashPage,
        ),
      );
    });
  }
}
