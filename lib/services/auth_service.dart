import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';

import '../app/app.router.dart';
import '../utils/toast_service.dart';
import 'error_handler.dart';
import 'otp_service.dart';
import 'pocketbase_service.dart';

class AuthService {
  final _navigationService = locator<NavigationService>();
  final _pocketBaseService = locator<PocketBaseService>();
  final _otpService = locator<OTPService>();
  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> signUp(
    String? fullNameValue,
    String? levelValue,
    String? emailValue,
    String? passwordValue,
    String? confirmPasswordValue,
  ) async {
    final body = <String, dynamic>{
      "name": fullNameValue,
      "email": emailValue,
      "level": levelValue,
      "password": passwordValue,
      "passwordConfirm": confirmPasswordValue
    };

    try {
      print(body);
      final record =
          await _pocketBaseService.pb.collection('users').create(body: body);
      print(record.data);
      await _otpService.sendOtp(emailValue!);
      ToastService.showSuccess(
        title: 'Sign up successful',
        description: 'Check your mail for OTP',
      );
      _navigationService.clearStackAndShow(Routes.verifyMail);
    } catch (e) {
      print('Error during sign up: $e');

      print('Error during sign up: $e');
      String errorMessage = 'An error occurred';

      if (e is ClientException) {
        final responseData = e.response['data'];
        if (responseData != null && responseData is Map) {
          final firstErrorField = responseData.values.firstWhere(
            (field) => field is Map && field.containsKey('message'),
            orElse: () => null,
          );
          if (firstErrorField != null) {
            errorMessage = firstErrorField['message'];
          }
        }
      }

      ToastService.showError(
        title: 'Sign up failed',
        description: errorMessage,
      );
    }
  }

  Future<void> signIn(String? emailValue, String? passwordValue) async {
    try {
      final authData = await _pocketBaseService.pb
          .collection('users')
          .authWithPassword(emailValue!, passwordValue!);
      print(authData.record);
      await secureStorage.write(key: "_accesskey", value: authData.token);
      await secureStorage.write(
        key: "email",
        value: authData.record?.data['email'],
      );
      await secureStorage.write(
        key: "name",
        value: authData.record?.data['name'],
      );
      ToastService.showSuccess(
        title: 'Success',
        description: 'Sign in successful',
      );
      _navigationService.clearStackAndShow(Routes.mapPage);
    } catch (e) {
      print('Error during sign up: $e');

      String errorMessage = 'An error occurred';

      if (e is ClientException) {
        final response = e.response;
        // Check if the response is a map and contains a message
        if (response.containsKey('message')) {
          errorMessage = response['message'];
        }
      }
      ToastService.showError(
        title: 'Sign up failed',
        description: errorMessage,
      );
    }
    //secureStorage.write(key: "name", value: name)
  }
}
