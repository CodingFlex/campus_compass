import 'package:campus_compass/services/supplement_dataset_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';

import '../app/app.router.dart';
import '../utils/toast_service.dart';
import 'pocketbase_service.dart';

class ContributionService {
  final _navigationService = locator<NavigationService>();
  final _pocketBaseService = locator<PocketBaseService>();
  final _supplementDatasetService = locator<SupplementDatasetService>();

  Future<void> sendContribution(
    String placeName,
    String? placeType,
    double longitude,
    double latitude,
  ) async {
    final coordinates = <String, dynamic>{
      "longitude": longitude,
      "latitude": latitude,
    };
    final body = <String, dynamic>{
      "place_name": placeName,
      "place_type": placeType,
      "coordinates": coordinates,
    };

    try {
      print(body);
      final record = await _pocketBaseService.pb
          .collection('User_Contributions')
          .create(body: body);
      print(record.data);
      ToastService.showSuccess(
        title: 'Success',
        description: 'Thanks for your contribution!',
      );
      _navigationService.clearStackAndShow(Routes.mapPage);
    } catch (e) {
      print('Error during sign up: $e');

      ToastService.showError(
        title: 'Failed',
        description: 'Please try again later',
      );
    }
  }
}
