import 'package:campus_compass/app/app.router.dart';
import 'package:campus_compass/services/auth_service.dart';
import 'package:campus_compass/ui/map/maps.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../utils/shared/ui_helpers.dart';
import '../../../utils/widgets/box_input_field.dart';

import '../widgets/auth_layout.dart';
import 'sign_up_view.form.dart';

import 'sign_up_viewmodel.dart';

@FormView(fields: [
  FormTextField(
      name: 'fullName', validator: SignUpFormValidation.validateFullName),
  FormTextField(name: 'email', validator: SignUpFormValidation.validateEmail),
  FormTextField(
      name: 'password', validator: SignUpFormValidation.validatePassword),
  FormTextField(
    name: 'confirmPassword',
  ),
])
class SignUpPage extends StatelessWidget with $SignUpPage {
  final _authService = locator<AuthService>();
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigationService = locator<NavigationService>();
    return ViewModelBuilder<SignUpPageViewModel>.reactive(
      onViewModelReady: (model) => syncFormWithViewModel(model),
      onDispose: (model) => disposeForm(),
      builder: (context, model, child) => Scaffold(
          body: AuthenticationLayout(
        busy: model.isBusy,
        onMainButtonTapped: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          await model.signUp();
          // model.save();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ChangeNotifierProvider(
          //       create: (context) => AppData(),
          //       child: MapScreen2(),
          //     ),
          //   ),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => MapScreen()),
          // );
        },
        // onBackPressed: model.navigateBack,
        // validationMessage: model.validationMessage,
        title: 'Join Our Campus Community',
        subtitle:
            'Create an account to personalize your experience and unlock all features',
        mainButtonTitle: 'Create My Account',
        onCreateAccountTapped: () => _navigationService.navigateToSignInPage(),
        form: Column(
          children: [
            BoxInputField(
                controller: fullNameController,
                placeholder: 'Full name',
                leading: Icon(
                  Icons.person_2_outlined,
                  color: Color.fromARGB(255, 80, 80, 80),
                )),
            verticalSpaceRegular,
            BoxInputField(
                controller: emailController,
                placeholder: 'Email',
                leading: Icon(
                  Icons.email_outlined,
                  color: Color.fromARGB(255, 80, 80, 80),
                )),
            verticalSpaceRegular,
            BoxInputField(
                controller: passwordController,
                password: true,
                placeholder: 'Password',
                leading: Icon(
                  Icons.lock_open,
                  color: Color.fromARGB(255, 80, 80, 80),
                )),
            verticalSpaceRegular,
            BoxInputField(
                controller: confirmPasswordController,
                password: true,
                placeholder: 'Confirm password',
                validator: model.showValidationMessage
                    ? (value) => SignUpFormValidation.validateConfirmPassword(
                        value, passwordController)
                    : null,
                leading: Icon(
                  Icons.lock_open,
                  color: Color.fromARGB(255, 80, 80, 80),
                )),
          ],
        ),
        showTermsText: true,
      )),
      viewModelBuilder: () => SignUpPageViewModel(),
    );
  }
}
