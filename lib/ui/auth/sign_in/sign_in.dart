import 'package:campus_compass/utils/shared/ui_helpers.dart';
import 'package:campus_compass/utils/widgets/box_input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../sign_up/sign_up_viewmodel.dart';
import 'sign_in_view_model.dart';
import 'sign_in_view.form.dart';
import '../widgets/auth_layout.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class SignInPage extends StatelessWidget with $SignInPage {
  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigationService = locator<NavigationService>();
    return ViewModelBuilder<SignUpPageModel>.reactive(
      //onViewModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
          body: AuthenticationLayout(
        busy: model.isBusy,
        signin: true,
        // onMainButtonTapped: model.saveData,
        // onCreateAccountTapped: model.navigateToCreateAccount,
        // validationMessage: model.validationMessage,
        title: 'Welcome Back',
        subtitle: 'Sign in to access your personalized campus guide',
        mainButtonTitle: 'Sign In',

        form: Column(
          children: [
            BoxInputField(
                controller: emailController,
                placeholder: 'Email',
                leading: Icon(
                  Icons.email,
                  color: const Color.fromARGB(255, 201, 201, 201),
                )),
            verticalSpaceRegular,
            BoxInputField(
                controller: passwordController,
                password: true,
                placeholder: 'Password',
                leading: Icon(
                  Icons.lock_open,
                  color: const Color.fromARGB(255, 201, 201, 201),
                )),
          ],
        ),
        onForgotPassword: () {
          _navigationService.navigateTo(Routes.signUpPage);
        },
        // onSignInWithGoogle: model.useGoogleAuthentication,
        // onSignInWithApple: model.useAppleAuthentication,
      )),
      viewModelBuilder: () => SignUpPageModel(),
    );
  }
}
