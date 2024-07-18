import 'package:dio/dio.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';

class AuthService {
  final _navigationService = locator<NavigationService>();

  final Dio _dio = Dio();
}
