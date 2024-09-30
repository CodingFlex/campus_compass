import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:campus_compass/constants/assets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../utils/shared/text_styles.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    final pageDecoration = PageDecoration(
      titleTextStyle: headlineStyle.copyWith(fontSize: 22.sp),
      bodyTextStyle: bodyStyle.copyWith(fontSize: 22.sp),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      curve: Curves.elasticIn,
      pages: [
        PageViewModel(
          title: "Navigate Your Campus",
          body:
              "Your pocket guide to classrooms, events, and everything in between",
          image: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              Assets.onboarding1,
              scale: 2,
            ),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 8,
            safeArea: 50,
          ),
        ),
        PageViewModel(
          title: 'Unleash Your Campus Experience',
          body:
              'Discover hidden gems, connect with peers, and make the most of your university life',
          image: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              Assets.onboarding2,
              scale: 1.5,
            ),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 7,
            safeArea: 50,
          ),
        ),
      ],
      onDone: () {
        _navigationService.navigateTo(Routes.signInPage);
      },
      onSkip: () {}, // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip', style: bodyStyle),
      next: const Icon(Icons.arrow_forward_ios_sharp),
      done: const Text('Done', style: bodyStyle),

      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Color.fromARGB(221, 230, 205, 240),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }
}
