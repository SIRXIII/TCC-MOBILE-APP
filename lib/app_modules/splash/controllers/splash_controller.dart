import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/select_account_type/models/account_type_model.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/firebase_options.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/service/fcm_notifications.dart';
import 'package:travel_clothing_club_flutter/service/stripe_service.dart';
import 'package:travel_clothing_club_flutter/utils/stripe_config.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';

class SplashController extends GetxController {
  final userPreferences = UserPreferences.instance;

  @override
  void onInit() {
    super.onInit();
    _checkOnboardingStatus();
    // googleAuthController.initializeGoogleSignIn();
  }

  void _checkOnboardingStatus() async {
    await UserPreferences.instance.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await initMessaging();

    await StripeConfig.initialize();

    // Stripe Init
    StripeService.init();

    if (UserPreferences.instance.isLoggedIn()) {
      debugPrint('✅ User is logged in');

      AppLogger.debugPrintLogs(
        'User Data',
        UserPreferences.instance.getUserData()?.traveler?.getName() ?? '',
      );
    } else {
      debugPrint('❌ User is logged out');
    }

    // userPreferences.loadLoggedInUserType();
    userPreferences.getLoggedInUserData();

    await Future.delayed(const Duration(seconds: 1));
    AppLogger.debugPrintLogs(
      'selectedUserType',
      userPreferences.selectedUserType,
    );

    if (userPreferences.selectedUserType == AccountTypeEnum.traveler) {
      Get.offAllNamed(AppRoutes.travelerDashboard);
    } else if (userPreferences.selectedUserType == AccountTypeEnum.rider) {
      Get.offAllNamed(AppRoutes.riderDashboard);
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }

    // Example for real app:
    // bool hasCompletedOnboarding = await _storage.read('onboarding_completed') ?? false;
    // if (hasCompletedOnboarding) {
    //   Get.offAllNamed(AppRoutes.accountType);
    // } else {
    //   Get.offAllNamed(AppRoutes.onboarding);
    // }
  }
}
