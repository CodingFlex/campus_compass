import 'package:campus_compass/ui/auth/sign_in/sign_in.dart';
import 'package:campus_compass/ui/map/maps.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stacked_services/stacked_services.dart';

import '../services/user_details_service.dart';
import '../ui/auth/sign_up/sign_up.dart';
import '../ui/onboarding/onboarding_page.dart';
import '../services/auth_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: OnboardingPage, initial: true),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: SignUpPage),
    MaterialRoute(page: MapScreen),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: UserDetailsService),
  ],
  logger: StackedLogger(),
)
class AppSetup {}
