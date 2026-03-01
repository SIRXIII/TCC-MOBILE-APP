// bindings/onboarding_binding.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/on_boarding/controller/onboarding_controller.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}