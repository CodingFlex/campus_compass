import 'dart:io';

import 'package:campus_compass/utils/shared/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastService {
  static final Toastification _toastification = Toastification();

  static void showSuccess(
      {required String title, required String description}) {
    _toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 4),
      title: Text(
        title,
        style: heading3Style.copyWith(color: Colors.green),
      ),
      description: Text(
        description,
        style: bodyStyle.copyWith(color: Colors.green),
      ),
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }

  static void showError({required String title, required String description}) {
    _toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        autoCloseDuration: const Duration(seconds: 3),
        title: Text(
          title,
          style: heading3Style.copyWith(color: Colors.red),
        ),
        description: Text(
          description,
          style: bodyStyle.copyWith(color: Colors.red),
        ),
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black);
  }

  static void showExceptionError(dynamic e) {
    String title = 'Error';
    String description;

    if (e is SocketException) {
      description = "Unable To Connect At This Time";
    } else if (e is DioException) {
      try {
        description =
            e.response?.data['message'] ?? "Unable To Connect At This Time";
      } catch (_) {
        description = "An unexpected error occurred";
      }
    } else {
      description = "An unexpected error occurred";
    }

    showError(title: title, description: description);
  }
}
