import 'package:campus_compass/utils/shared/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:campus_compass/constants/assets.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
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
          titleWidget: Align(
            alignment: Alignment.center,
            child: Text(
              'Navigate Your Campus',
              style: headlineStyle,
            ),
          ),
          bodyWidget: Text(
            'Your pocket guide to classrooms, events, and everything in between',
            style: heading1Style,
          ),
          image: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              Assets.onboarding2,
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            'Unlock Your Campus Potential',
            style: headlineStyle,
          ),
          bodyWidget: Text(
            'Discover hidden gems, connect with peers, and make the most of your university life',
            style: heading1Style,
          ),
          image: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              Assets.onboarding1,
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () {},
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
