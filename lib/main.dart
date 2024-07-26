import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'app/app.router.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'package:provider/provider.dart';

import 'services/user_details_service.dart';
import 'ui/map/DataHandler/appData.dart';

void main() async {
  setupLocator();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
    initializeMapRenderer();
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  initializeLocationAndSave();
  runApp(MyApp());
  // MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(create: (context) => AppData()),
  //     // Add other providers here if needed
  //   ],
  //   child: MyApp(),
  // );
}

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    unawaited(mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest)
        .then((AndroidMapRenderer initializedRenderer) =>
            completer.complete(initializedRenderer)));
  } else {
    completer.complete(null);
  }

  return completer.future;
}

void initializeLocationAndSave() async {
  // Ensure all permissions are collected for Locations

  bool? _serviceEnabled;

  LocationPermission _permission;

  _serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!_serviceEnabled) {}

  _permission = await Geolocator.checkPermission();

  if (_permission == LocationPermission.denied) {
    _permission = await Geolocator.requestPermission();
  }
  final UserDetailsService _userDetailsService = locator<UserDetailsService>();
  _userDetailsService.getUserDetails();

  // Get the current usesr location

  // Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.best);

  // LatLng currentLocation = LatLng(position.latitude, position.longitude);

  // // Get the current user address
  // String currentAddress =
  //     (await getParsedReverseGeocoding(currentLocation))['place'];

  // // Store the user location in sharedPreferences
  // sharedPreferences.setDouble('latitude', position.latitude);
  // sharedPreferences.setDouble('longitude', position.longitude);
  // sharedPreferences.setString('current-address', currentAddress);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: Routes.splashPage,
    );
  }
}
