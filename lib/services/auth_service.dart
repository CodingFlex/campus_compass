import 'package:campus_compass/services/supplement_dataset_service.dart';
import 'package:campus_compass/utils/user_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final _supplementDatasetService = locator<SupplementDatasetService>();

  final _otpService = locator<OTPService>();
  UserSecureStorage secureStorage = UserSecureStorage();

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

  Future<void> signInWithGoogle() async {
    print('started');
    try {
      // Initialize Google Sign-In
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      print('started');
      if (googleUser == null) {
        throw Exception('Google Sign-In was canceled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Use the obtained token to authenticate with PocketBase

      final authData =
          await _pocketBaseService.pb.collection('users').authWithOAuth2(
        'google',
        (url) async {},
        createData: {
          'name': googleUser.displayName,
          'email': googleUser.email,
        },
      );

      // At this point, the user is signed in
      // You can access the user data with authData.record
      print('Signed in: ${authData.record!.id}');

      // Navigate to a new screen or update UI
    } catch (e) {
      print('Error during Google Sign-In: $e');
      // Handle the error (show a snackbar, display an error message, etc.)
    }
  }

  Future<void> signIn(String? emailValue, String? passwordValue) async {
    try {
      final authData = await _pocketBaseService.pb
          .collection('users')
          .authWithPassword(emailValue!, passwordValue!);
      print(authData.token);
      await UserSecureStorage.setAccessKey(authData.token);
      await UserSecureStorage.setName(authData.record?.data['name']);
      await UserSecureStorage.setEmail(authData.record?.data['email']);

      _navigationService.clearStackAndShow(Routes.mapPage);
      await _supplementDatasetService.fetchDataSetRecords();
      ToastService.showSuccess(
        title: 'Success',
        description: 'Sign in successful',
      );
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
