import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';

class AppResponse {
  static final snackBar = locator<SnackbarService>();

  static showSuccess(String message) {
    snackBar.showSnackbar(
      title: "Success",
      message: message,
      duration: const Duration(seconds: 5),
      // backgroundColor: Colors.green.withOpacity(.4),
    );
  }

  static showError(String message) {
    snackBar.showSnackbar(
      title: "Error",
      message: message,
      duration: const Duration(seconds: 5),
      // backgroundColor: Colors.green.withOpacity(.4),
    );
  }

  static showComingSoon(String message) {
    snackBar.showSnackbar(
      title: "Coming Soon",
      message: message,
      duration: const Duration(seconds: 5),
      // backgroundColor: Colors.green.withOpacity(.4),
    );
  }

  static showExceptionError(dynamic e) {
    if (e is SocketException) {
      snackBar.showSnackbar(
        title: 'Error',
        message: "Unable To Connect At This Time",
        duration: const Duration(seconds: 5),
        // backgroundColor: Colors.red.withOpacity(.4),
      );
      return;
    }
    if (e is SocketException) {
      snackBar.showSnackbar(
        title: 'Error',
        message: "Unable To Connect At This Time",
        duration: const Duration(seconds: 5),
        // backgroundColor: Colors.red.withOpacity(.4),
      );
      return;
    }
    if (e is DioException) {
      try {
        e.response!.statusCode != null
            ? snackBar.showSnackbar(
                title: "Error",
                message: '${e.response!.data['message']}',
                // backgroundColor: Colors.red.withOpacity(.4)
              )
            : snackBar.showSnackbar(
                title: 'Error',
                message: "Unable To Connect At This Time",
                // backgroundColor: Colors.red.withOpacity(.4),
              );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
