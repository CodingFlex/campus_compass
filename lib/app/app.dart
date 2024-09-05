import 'package:campus_compass/services/contribution_service.dart';
import 'package:campus_compass/services/pocketbase_service.dart';
import 'package:campus_compass/services/supplement_dataset_service.dart';
import 'package:campus_compass/services/user_location_service.dart';
import 'package:campus_compass/ui/auth/sign_in/sign_in.dart';
import 'package:campus_compass/ui/map/maps.dart';
import 'package:campus_compass/ui/map2/map_viewmodel.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:stacked_services/stacked_services.dart';

import '../services/otp_service.dart';
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
    LazySingleton(classType: UserLocationService),
    LazySingleton(classType: PocketBaseService),
    LazySingleton(classType: OTPService),
    LazySingleton(classType: MapViewModel),
    LazySingleton(classType: SupplementDatasetService),
    LazySingleton(classType: ContributionService),
  ],
  logger: StackedLogger(),
)
class AppSetup {}
