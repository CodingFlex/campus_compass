import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/app/app.router.dart';
import 'package:campus_compass/services/connection_listener.dart';
import 'package:campus_compass/utils/toast_service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ExceptionViewModel extends BaseViewModel {
  final _connectionViewModel = locator<ConnectionViewModel>();
  final _navigationService = locator<NavigationService>();

  void navigateToMap() {
    if (_connectionViewModel.status == InternetConnectionStatus.connected) {
      _navigationService.navigateTo(Routes.mapPage);
    } else {
      ToastService.showError(
          title: 'Error', description: 'Couldn\'t connect to internet');
    }
  }

  void getPermission() {}
}
