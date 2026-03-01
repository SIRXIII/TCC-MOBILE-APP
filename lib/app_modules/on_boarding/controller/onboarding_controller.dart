// controllers/onboarding_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/on_boarding/model/onboarding_model.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/constants/app_images.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      image: AppImages.onBoard1,
      title: 'Travel Light, Arrive in Style',
      description:
          'Browse curated collections at your destination — fashion, essentials, and lifestyle items ready when you arrive.',
    ),
    OnboardingModel(
      image: AppImages.onBoard2,
      title: 'Reserve What You Need',
      description:
          'Choose products in your size and style. We’ll prepare them for you before you land.',
    ),
    OnboardingModel(
      image: AppImages.onBoard3,
      title: 'Delivered to Your Doorstep',
      description:
          'Your reserved items arrive at your hotel, Airbnb, or home ready to wear, stress-free.',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      completeOnboarding();
    }
  }

  void completeOnboarding() {
    Get.offAllNamed(AppRoutes.accountType);
  }

  void skipToEnd() {
    completeOnboarding();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
