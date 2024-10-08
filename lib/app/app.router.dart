// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:campus_compass/ui/auth/otp/verify_mail_screen.dart';
import 'package:campus_compass/ui/exceptions/network_exception.dart';

import 'package:campus_compass/ui/map2/map.dart';
import 'package:campus_compass/ui/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:stacked_services/stacked_services.dart';

import '../ui/auth/sign_in/sign_in.dart';
import '../ui/auth/sign_up/sign_up.dart';
import '../ui/onboarding/splash.dart';

class Routes {
  static const signInPage = '/signIn-page';
  static const signUpPage = '/signUp-page';
  static const splashPage = '/splash-page';
  static const onboardingPage = '/onboarding-page';
  static const verifyMail = '/verifyMail-page';
  static const mapPage = '/map-page';
  static const networkExceptionPage = '/network-exception-page';

  static const all = <String>{
    signInPage,
    signUpPage,
    splashPage,
    onboardingPage,
    mapPage,
    verifyMail,
    networkExceptionPage
  };
}

class StackedRouter extends RouterBase {
  final _routes = <RouteDef>[
    RouteDef(
      Routes.signInPage,
      page: SignInPage,
    ),
    RouteDef(
      Routes.signUpPage,
      page: SignUpPage,
    ),
    RouteDef(
      Routes.splashPage,
      page: SplashScreen,
    ),
    RouteDef(
      Routes.onboardingPage,
      page: OnboardingPage,
    ),
    RouteDef(
      Routes.verifyMail,
      page: VerifyMail,
    ),
    RouteDef(
      Routes.mapPage,
      page: MapScreen2,
    ),
    RouteDef(
      Routes.networkExceptionPage,
      page: NetworkExceptionView,
    ),
  ];

  final _pagesMap = <Type, StackedRouteFactory>{
    SignInPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInPage(),
        settings: data,
      );
    },
    SignUpPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpPage(),
        settings: data,
      );
    },
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    OnboardingPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnboardingPage(),
        settings: data,
      );
    },
    VerifyMail: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyMail(),
        settings: data,
      );
    },
    MapScreen2: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MapScreen2(),
        settings: data,
      );
    },
    NetworkExceptionView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NetworkExceptionView(),
        settings: data,
      );
    },
  };
  @override
  List<RouteDef> get routes => _routes;
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
}

extension NavigatorStateExtension on NavigationService {
  Future<dynamic> navigateToSignInPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signInPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSplashPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerifyMailPage([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.verifyMail,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMapScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mapPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNetworkExceptionScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.networkExceptionPage,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
