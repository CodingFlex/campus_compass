import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:campus_compass/constants/assets.dart';
import 'package:flutter/material.dart';
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
        Future.delayed(const Duration(milliseconds: 3000), () {
          _navigationService.navigateTo(Routes.onboardingPage);
        });
        // var response = await userRepository.getUserData();
        // if (response.status == 200 && response.data.isAuthenticated) {
        //   GoRouter.of(context).goNamed("home");
        // } else {
        //   // GoRouter.of(context).goNamed("/");
        // }
      },
    );
  }
}
