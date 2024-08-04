import 'package:flutter/material.dart';

class FieldValidators {
  // Check if the field is empty
  static String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return '*Field required';
    }
    return null;
  }

  // Check if the field matches a specific regex
  static String? validateRegex(String? value, String pattern,
      {String? errorMessage}) {
    if (value == null || !RegExp(pattern).hasMatch(value)) {
      return errorMessage ?? 'Invalid input';
    }
    return null;
  }

  // Specific validation examples
  static String? validateEmail(String? value) {
    return validateRegex(value,
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        errorMessage: 'Valid email is required');
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '*Field required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // Check if the confirmation password matches the original password
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
