// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:campus_compass/services/otp_service.dart';
import 'package:campus_compass/services/user_details_service.dart';
import 'package:campus_compass/ui/map2/map_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/auth_service.dart';
import '../services/pocketbase_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserDetailsService());
  locator.registerSingleton(PocketBaseService());
  locator.registerSingleton(OTPService());
  locator.registerLazySingleton(() => MapViewModel());
}
