import 'dart:async';

import 'package:campus_compass/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';

class ConnectionViewModel {
  final _connectionChecker = InternetConnectionChecker();
  late final StreamSubscription<InternetConnectionStatus> _subscription;
  final _navigationService = locator<NavigationService>();
  InternetConnectionStatus _status =
      InternetConnectionStatus.connected; // Declare _status
  InternetConnectionStatus get status => _status; // Getter for _status

  void startListeningForInternetChanges() {
    _connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        _status = status;
        _navigationService.navigateTo(Routes.networkExceptionPage);
      } else {
        _status = status;
      }
    });
  }
}
