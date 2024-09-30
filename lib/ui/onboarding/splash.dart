import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:campus_compass/constants/assets.dart';
import 'package:campus_compass/services/user_details_service.dart';
import 'package:campus_compass/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../utils/shared/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _navigationService = locator<NavigationService>();
  final _userDetailsService = locator<UserDetailsService>();
  String? token;

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  Future<void> fetchToken() async {
    token = await UserSecureStorage.getAccessKey();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [kcPrimaryColor, kcMediumGreyColor],
      ),
      childWidget: SizedBox(
        height: 350,
        child: Image.asset(Assets.splash, scale: 1),
      ),
      asyncNavigationCallback: () async {
        await Future.delayed(
            Duration(milliseconds: 3000)); // adjust the delay as needed
        bool ifr = await IsFirstRun.isFirstRun();
        if (ifr == true) {
          _navigationService.navigateTo(Routes.onboardingPage);
        } else if (token != null) {
          bool hasExpired = JwtDecoder.isExpired(token!);
          print('Result of $hasExpired');
          if (hasExpired == false) {
            _navigationService.navigateTo(Routes.mapPage);
          } else {
            print('this runs this');
            _navigationService.navigateTo(Routes.signInPage);
          }
        } else {
          print('this runs that');
          _navigationService.navigateTo(Routes.signInPage);
        }
      },
    );
  }
}
