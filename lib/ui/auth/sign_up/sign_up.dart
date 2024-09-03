import 'package:campus_compass/app/app.router.dart';
import 'package:campus_compass/services/auth_service.dart';
import 'package:campus_compass/ui/map/maps.dart';
import 'package:campus_compass/utils/widgets/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
  FormTextField(name: 'fullName'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
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
            CustomisedTextFormField(
              leading: Icon(
                Icons.person_2_outlined,
                color: Color.fromARGB(255, 80, 80, 80),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.match(r'^[a-zA-Z ]+$',
                    errorText: 'Only alphabets are allowed'),
              ]),
              hintText: 'Full Name',
              showSuffixIcon: false,
              controller: fullNameController,
            ),
            verticalSpaceRegular,
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
                    errorText: 'passwords must have at least one number'),
              ]),
              hintText: 'Password',
              showSuffixIcon: true,
              controller: passwordController,
            ),
            verticalSpaceRegular,
            CustomisedTextFormField(
              leading: Icon(
                Icons.lock_outline,
                color: Color.fromARGB(255, 80, 80, 80),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.equal(passwordController.text,
                    errorText: 'Passwords do not match'),
                FormBuilderValidators.minLength(8),
                FormBuilderValidators.match(r'(?=.*?[#?!@$%^&*-])',
                    errorText:
                        'passwords must have at least one special character'),
                FormBuilderValidators.match(r'(?=.*?[0-9])',
                    errorText: 'passwords must have at least one number'),
              ]),
              hintText: 'Confirm password',
              showSuffixIcon: true,
              controller: confirmPasswordController,
            ),
          ],
        ),
        showTermsText: true,
      )),
      viewModelBuilder: () => SignUpPageViewModel(),
    );
  }
}
