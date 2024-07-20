import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../utils/shared/ui_helpers.dart';
import '../../../utils/widgets/box_input_field.dart';
import '../widgets/auth_layout.dart';
import 'sign_up_view.form.dart';
import 'sign_up_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'fullName'),
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class SignUpPage extends StatelessWidget with $SignUpPage {
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpPageModel>.reactive(
      //onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
          body: AuthenticationLayout(
        busy: model.isBusy,
        // onMainButtonTapped: model.saveData,
        // onBackPressed: model.navigateBack,
        // validationMessage: model.validationMessage,
        title: 'Join Our Campus Community',
        subtitle:
            'Create an account to personalize your experience and unlock all features',
        mainButtonTitle: 'Create My Account',
        form: Column(
          children: [
            BoxInputField(
                controller: fullNameController,
                placeholder: 'Full name',
                leading: Icon(
                  Icons.person,
                  color: const Color.fromARGB(255, 201, 201, 201),
                )),
            verticalSpaceRegular,
            BoxInputField(
                controller: emailController,
                password: true,
                placeholder: 'Email',
                leading: Icon(
                  Icons.email,
                  color: const Color.fromARGB(255, 201, 201, 201),
                )),
            verticalSpaceRegular,
            BoxInputField(
                controller: passwordController,
                password: true,
                placeholder: 'Confirm password',
                leading: Icon(
                  Icons.lock_open,
                  color: const Color.fromARGB(255, 201, 201, 201),
                )),
          ],
        ),
        showTermsText: true,
      )),
      viewModelBuilder: () => SignUpPageModel(),
    );
  }
}
