import 'dart:async';

import 'package:campus_compass/app/app.locator.dart';
import 'package:campus_compass/app/app.router.dart';
import 'package:campus_compass/services/otp_service.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/auth_service.dart';
import '../../../utils/toast_service.dart';

class OtpViewModel extends BaseViewModel {
  OtpFieldController otpController = OtpFieldController();
  final _authService = locator<AuthService>();
  bool? confirmResult = true;
  final _navigationService = locator<NavigationService>();
  final _otpService = locator<OTPService>();
  int minutes = 1;
  int seconds = 0;
  // Getter for stored email
  String? get storedEmail => _otpService.storedEmail;
  Timer? _timer;

  void resendOTP() async {
    await _otpService.resendOTP();
  }

  //OTP timer count down
  void startCountdown() {
    const oneSecond = Duration(seconds: 1);

    _timer = Timer.periodic(oneSecond, (timer) {
      if (minutes == 0 && seconds == 0) {
        timer.cancel(); // Stop the timer when countdown reaches 0
        return;
      }

      if (seconds == 0) {
        minutes--;
        seconds = 59;
      } else {
        seconds--;
      }

      notifyListeners(); // Notify listeners to update the UI
    });
  }

  void restartCountdown() {
    _timer?.cancel();
    otpController.clear();
    minutes = 1; // Set your desired initial minutes
    seconds = 0; // Set your desired initial seconds
    startCountdown(); // Start the countdown again
  }

  initOTP({required String? pin}) async {
    setBusy(true);
    notifyListeners();
    await _otpService.verifyOTP(pin);
    setBusy(false);
    notifyListeners();
    ToastService.showSuccess(
      title: 'Verification Successful',
      description: 'Sign in to access your account.',
    );
    _navigationService.clearStackAndShow(Routes.signInPage);
  }
}
