import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../sign_in/sign_in_view_model.dart';
import 'sign_up_view.form.dart';

class SignUpPageModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  save() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      _navigationService.navigateTo(Routes.mapPage);
    });
  }
  // final _firebaseAuthenticationService =
  //     locator<FirebaseAuthenticationService>();

  // CreateAccountViewModel() : super(successRoute: Routes.addressSelectionView);

  // @override
  // Future<FirebaseAuthenticationResult> runAuthentication() =>
  //     _firebaseAuthenticationService.createAccountWithEmail(
  //       email: emailValue!,
  //       password: passwordValue!,
  //     );

  // void navigateBack() => navigationService.back();
}
