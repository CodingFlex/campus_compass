import 'package:campus_compass/ui/map/maps.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../../../utils/shared/ui_helpers.dart';
import '../../../utils/widgets/box_input_field.dart';
import '../../map/DataHandler/appData.dart';
import '../../map2/bottomsheet.dart';
import '../../map2/map.dart';
import '../widgets/auth_layout.dart';
import 'sign_up_view.form.dart';
import 'package:provider/provider.dart';
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
        onMainButtonTapped: () {
          // model.save();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => AppData(),
                child: MapScreen2(),
              ),
            ),
          );
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
                controller: fullNameController,
                placeholder: 'School',
                leading: Icon(
                  Icons.school_outlined,
                  color: Color.fromARGB(255, 80, 80, 80),
                )),
            verticalSpaceRegular,
            BoxInputField(
                controller: fullNameController,
                placeholder: 'Matric number',
                leading: Icon(
                  Icons.person_2_outlined,
                  color: Color.fromARGB(255, 80, 80, 80),
                )),
            verticalSpaceRegular,
            BoxInputField(
                controller: emailController,
                password: true,
                placeholder: 'Email',
                leading: Icon(
                  Icons.email_outlined,
                  color: Color.fromARGB(255, 80, 80, 80),
                )),
            verticalSpaceRegular,
            BoxInputField(
                controller: passwordController,
                password: true,
                placeholder: 'Confirm password',
                leading: Icon(
                  Icons.lock_open,
                  color: Color.fromARGB(255, 80, 80, 80),
                )),
          ],
        ),
        showTermsText: true,
      )),
      viewModelBuilder: () => SignUpPageModel(),
    );
  }
}
