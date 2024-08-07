import 'package:campus_compass/ui/auth/sign_in/sign_in_view.form.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/auth_service.dart';

class SignInPageViewModel extends FormViewModel {
  final formKey = GlobalKey<FormState>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  /// to check if the form is validated
  signIn() async {
    setBusy(true);
    notifyListeners();

    await _authService.signIn(
      emailValue,
      passwordValue,
    );
    setBusy(false);
    notifyListeners();
  }

  /// calling the login endpoint

  // final FirebaseAuthenticationService? _firebaseAuthenticationService =
  //     locator<FirebaseAuthenticationService>();

  // LoginViewModel() : super(successRoute: Routes.addressSelectionView);

  // @override
  // Future<FirebaseAuthenticationResult> runAuthentication() =>
  //     _firebaseAuthenticationService!.loginWithEmail(
  //       email: emailValue!,
  //       password: passwordValue!,
  //     );

  void navigateToCreateAccount() =>
      _navigationService.navigateTo(Routes.signUpPage);
}
