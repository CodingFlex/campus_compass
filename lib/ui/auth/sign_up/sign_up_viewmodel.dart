import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/auth_service.dart';
import 'sign_up_view.form.dart';

class SignUpPageViewModel extends FormViewModel {
  final formKey = GlobalKey<FormState>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  // /// to check if the form is validated
  // bool validateAndSave() {
  //   final form = formKey.currentState;
  //   if (form!.validate()) {
  //     form.save();
  //     return true;
  //   }
  //   return false;
  // }

  /// calling the login endpoint
  signUp() async {
    setBusy(true);
    notifyListeners();

    await _authService.signUp(
      fullNameValue,
      emailValue,
      passwordValue,
      confirmPasswordValue,
    );

    setBusy(false);
    notifyListeners();
  }

  void navigateToCreateAccount() =>
      _navigationService.navigateTo(Routes.signUpPage);
}

class SignUpFormValidation {
  static String? validateFullName(String? value) {
    if (value == null) {
      return '*field required';
    } else {
      return null;
    }
  }

  static String? validateLevel(String? value) {
    if (value == null) {
      return '*field required';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) => value!.isEmpty
      ? '*field required'
      : !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)
          ? 'valid email is required'
          : null;
  static String? validatePassword(String? value) {
    if (value == null) {
      return '*field required';
    } else if (!RegExp(r"\^{8,}$").hasMatch(value)) {
      return "*minimum of 8 character is required";
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? value, TextEditingController passwordController) {
    if (value == null || value.isEmpty) {
      return '*Field required';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
