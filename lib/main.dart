import 'dart:async';

import 'package:campus_compass/services/user_location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:toastification/toastification.dart';

import 'app/app.locator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'app/app.router.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'package:provider/provider.dart';

import 'services/user_details_service.dart';
import 'ui/map/DataHandler/appData.dart';
import 'ui/map2/map_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  initializeLocationAndSave();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppData()),
        // Add other providers here if needed
      ],
      child: MyApp(),
    ),
  );
}

Future<void> initializeLocationAndSave() async {
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        initialRoute: Routes.splashPage,
      ),
    );
  }
}
