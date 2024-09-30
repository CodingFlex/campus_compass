import 'package:campus_compass/ui/auth/otp/otp_viewmodel.dart';
import 'package:campus_compass/utils/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gap/gap.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../utils/shared/app_colors.dart';
import '../../../utils/shared/text_styles.dart';

class VerifyMail extends StatefulWidget {
  const VerifyMail({super.key});

  @override
  State<VerifyMail> createState() => _VerifyMailState();
}

final _navigationService = locator<NavigationService>();

class _VerifyMailState extends State<VerifyMail> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.reactive(
      viewModelBuilder: () => OtpViewModel(),
      onViewModelReady: (model) {
        model.startCountdown();
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          // await model.showConfirmationDialog();
          // If the user confirmed (clicked "Yes"), exit the app
          if (model.confirmResult == true) {
            SystemNavigator.pop();
            return true;
          } else {
            return false;
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              // leading: IconButton(
              //   padding: AppPaddings.getCustomPadding(context, 0.085),
              //   icon: const Icon(Icons.arrow_back),
              //   iconSize: MediaQuery.of(context).size.width * 0.06,
              //   color: Colors.black,
              //   onPressed: () =>
              //       _navigationService.navigateTo(Routes.loginPage),
              // ),
              elevation: 0,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Verify Mail', style: heading2Style),
                        const SizedBox(width: 3),
                        Text('A code has been sent to', style: heading3Style),
                        verticalSpaceSmall,
                        Text(model.storedEmail!,
                            style: subheadingStyle.copyWith(
                              color: kcPrimaryColor,
                            )),
                        verticalSpaceMedium,
                        OTPTextField(
                            controller: model.otpController,
                            length: 4,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 70,
                            keyboardType: TextInputType.number,
                            fieldStyle: FieldStyle.box,
                            otpFieldStyle: OtpFieldStyle(
                              focusBorderColor: kcPrimaryColor,
                              disabledBorderColor: Colors.black,
                              enabledBorderColor: Colors.black,
                              borderColor: Colors.black,
                            ),
                            outlineBorderRadius: 15,
                            style: const TextStyle(fontSize: 17),
                            onChanged: (pin) {
                              print("Changed: $pin");
                            },
                            onCompleted: (pin) {
                              print("Completed: $pin");
                              model.initOTP(pin: pin);
                            }),
                        verticalSpaceRegular,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Code expires in ',
                                    style: subheadingStyle.copyWith(
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text:
                                        '${model.minutes}:${model.seconds.toString().padLeft(2, '0')}',
                                    style: subheadingStyle.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        verticalSpaceSmall,
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Didn\'t get a code?',
                                    style: subheadingStyle),
                                const Gap(3),
                                GestureDetector(
                                  onTap: () {
                                    model.resendOTP();
                                    model.restartCountdown();
                                  },
                                  child: Text('Resend code',
                                      style: subheadingStyle.copyWith(
                                        color: kcPrimaryColor,
                                      )),
                                ),
                              ],
                            ),
                            verticalSpaceMedium,
                            GestureDetector(
                              onTap: () {
                                //model.initOTP(pin: pin);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: kcPrimaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: model.isBusy
                                    ? CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      )
                                    : Text(
                                        'Verify',
                                        style: subheadingStyle.copyWith(
                                            color: Colors.white, fontSize: 18),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
