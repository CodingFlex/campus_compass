import 'package:campus_compass/ui/auth/sign_in/sign_in.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stacked_services/stacked_services.dart';

import '../ui/auth/sign_up/sign_up.dart';
import '../ui/onboarding/onboarding_page.dart';
import '../services/auth_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: OnboardingPage, initial: true),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: SignUpPage),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: AuthService),
  ],
  logger: StackedLogger(),
)
class AppSetup {}
