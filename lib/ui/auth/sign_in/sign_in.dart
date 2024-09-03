import 'package:campus_compass/services/auth_service.dart';
import 'package:campus_compass/utils/shared/ui_helpers.dart';
import 'package:campus_compass/utils/widgets/box_input_field.dart';
import 'package:campus_compass/utils/widgets/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
  FormTextField(name: 'email', validator: SignInValidators.validateEmail),
  FormTextField(name: 'password', validator: SignInValidators.validatePassword),
])
class SignInPage extends StatelessWidget with $SignInPage {
  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigationService = locator<NavigationService>();
    final _authService = locator<AuthService>();
    return ViewModelBuilder<SignInPageViewModel>.reactive(
      onViewModelReady: (model) => syncFormWithViewModel(model),
      onDispose: (model) => disposeForm(),
      builder: (context, model, child) => Scaffold(
          body: AuthenticationLayout(
              busy: model.isBusy,
              signin: true,
              onMainButtonTapped: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                model.signIn();
              },
              // onCreateAccountTapped: model.navigateToCreateAccount,
              validationMessage: model.validationMessage,
              title: 'Welcome Back',
              subtitle: 'Sign in to access your personalized campus guide',
              mainButtonTitle: 'Sign In',
              onCreateAccountTapped: () =>
                  _navigationService.navigateToSignUpPage(),
              form: Form(
                key: model.formKey,
                child: Column(
                  children: [
                    CustomisedTextFormField(
                      leading: Icon(
                        Icons.email_outlined,
                        color: Color.fromARGB(255, 80, 80, 80),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                      hintText: 'Email',
                      showSuffixIcon: false,
                      controller: emailController,
                    ),
                    verticalSpaceRegular,
                    CustomisedTextFormField(
                      leading: Icon(
                        Icons.lock_outline,
                        color: Color.fromARGB(255, 80, 80, 80),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(8),
                        FormBuilderValidators.match(r'(?=.*?[#?!@$%^&*-])',
                            errorText:
                                'passwords must have at least one special character'),
                        FormBuilderValidators.match(r'(?=.*?[0-9])',
                            errorText:
                                'passwords must have at least one number'),
                      ]),
                      hintText: 'Password',
                      showSuffixIcon: true,
                      controller: passwordController,
                    ),
                  ],
                ),
              ),
              onForgotPassword: () {
                _navigationService.navigateTo(Routes.signUpPage);
              },
              onSignInWithGoogle: () {
                _authService.signInWithGoogle();
              },
              onSignInWithApple: () {
                _authService.signInWithGoogle();
              })),
      viewModelBuilder: () => SignInPageViewModel(),
    );
  }
}
