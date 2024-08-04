import 'package:email_otp/email_otp.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../utils/toast_service.dart';

class OTPService {
  final EmailOTP _emailOTP;
  String? _storedEmail; // Private variable to store the email address

  OTPService() : _emailOTP = EmailOTP();
  final _navigationService = locator<NavigationService>();
  // Getter for the stored email
  String? get storedEmail => _storedEmail;

  Future<void> sendOtp(String email) async {
    try {
      _storedEmail = email; // Store the email address
      _emailOTP.setTheme(theme: "v3");
      await _emailOTP.setConfig(
        appEmail: "dunmadeoluwatunmise@gmail.com",
        appName: "Campus Compass",
        userEmail: email,
        otpLength: 4,
        otpType: OTPType.digitsOnly,
      );
      await _emailOTP.sendOTP();
      print('OTP sent to $email');
    } catch (e) {
      print('Error sending OTP: $e');
      throw Exception('Failed to send OTP.');
    }
  }

  Future<bool> verifyOTP(String? inputOtp) async {
    try {
      print(inputOtp);
      print('otp is here');
      bool isVerified = await _emailOTP.verifyOTP(otp: inputOtp.toString());
      print('OTP verification result: $isVerified');
      return isVerified;
    } catch (e) {
      print('Error during sign up: $e');

      ToastService.showError(
        title: 'Failed',
        description: 'OTP verification failed. Please try again.',
      );
      return false;
    }
  }

  Future<void> resendOTP() async {
    try {
      await sendOtp(
          _storedEmail!); // Use the stored email address to resend OTP
    } catch (e) {
      print('Error resending OTP: $e');
      ToastService.showError(
        title: 'Failed',
        description: 'Please try again later',
      );
    }
  }
}
