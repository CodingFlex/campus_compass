// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:campus_compass/ui/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:stacked_services/stacked_services.dart';

import '../ui/auth/sign_in.dart';
import '../ui/onboarding/splash.dart';

class Routes {
  static const signInPage = '/signIn-page';
  static const splashPage = '/splash-page';
  static const onboardingPage = '/onboarding-page';

  static const all = <String>{
    signInPage,
    splashPage,
    onboardingPage,
  };
}

class StackedRouter extends RouterBase {
  final _routes = <RouteDef>[
    RouteDef(
      Routes.signInPage,
      page: SignInPage,
    ),
    RouteDef(
      Routes.splashPage,
      page: SplashScreen,
    ),
    RouteDef(
      Routes.onboardingPage,
      page: OnboardingPage,
    ),
  ];

  final _pagesMap = <Type, StackedRouteFactory>{
    SignInPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInPage(),
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
}
