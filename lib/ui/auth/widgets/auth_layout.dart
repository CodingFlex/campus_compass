import 'dart:io';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:campus_compass/constants/assets.dart';
import 'package:campus_compass/utils/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utils/shared/app_colors.dart';
import '../../../utils/shared/ui_helpers.dart';
import '../../../utils/widgets/box_text.dart';

class AuthenticationLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool active;
  final bool? signin;
  final String? mainButtonTitle;
  final Widget? form;
  final bool showTermsText;
  final void Function()? onMainButtonTapped;
  final void Function()? onCreateAccountTapped;
  final void Function()? onForgotPassword;
  final void Function()? onBackPressed;
  final void Function()? onSignInWithApple;
  final void Function()? onSignInWithGoogle;
  final String? validationMessage;
  final bool busy;

  const AuthenticationLayout({
    Key? key,
    this.title,
    this.signin,
    this.active = false,
    this.subtitle,
    this.mainButtonTitle,
    this.form,
    this.onMainButtonTapped,
    this.onCreateAccountTapped,
    this.onForgotPassword,
    this.onBackPressed,
    this.onSignInWithApple,
    this.onSignInWithGoogle,
    this.validationMessage,
    this.showTermsText = false,
    this.busy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(
        children: [
          if (onBackPressed == null) verticalSpaceLarge,
          if (onBackPressed != null) verticalSpaceRegular,
          if (onBackPressed != null)
            IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: onBackPressed,
            ),
          if (signin == true)
            Center(
              child: Image.asset(
                Assets.splash2,
                scale: 1.75,
              ),
            ),
          Text(
            title!,
            style: headlineStyle,
          ),
          verticalSpaceSmall,
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: screenWidthPercentage(context, percentage: 0.7),
              child: BoxText.body(
                subtitle!,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          verticalSpaceRegular,
          form!,
          verticalSpaceRegular,
          if (onForgotPassword != null)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: onForgotPassword,
                  child: BoxText.body(
                    'Forget Password?',
                  )),
            ),
          verticalSpaceRegular,
          if (validationMessage != null)
            BoxText.body(
              validationMessage!,
              color: Colors.red,
            ),
          if (validationMessage != null) verticalSpaceRegular,
          GestureDetector(
            onTap: active ? onMainButtonTapped : null,
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? kcPrimaryColor : kcMediumGreyColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: busy
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      mainButtonTitle!,
                      style: subheadingStyle.copyWith(color: Colors.white),
                    ),
            ),
          ),
          verticalSpaceSmall,
          if (showTermsText)
            BoxText.body(
              'By signing up you agree to our terms, conditions and privacy policy.',
            ),
          verticalSpaceTiny,
          GestureDetector(
            onTap: onCreateAccountTapped,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    signin == true
                        ? 'Don\'t have an account?'
                        : 'Already have an account?',
                    style: bodyStyle),
                horizontalSpaceTiny,
                Text(
                  signin == true ? 'Create an account' : 'Sign in',
                  style: bodyStyle.copyWith(color: kcPrimaryColor),
                )
              ],
            ),
          ),
          verticalSpaceTiny,
        ],
      ),
    );
  }
}
