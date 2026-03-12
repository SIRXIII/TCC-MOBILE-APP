// views/onboarding_view.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/on_boarding/controller/onboarding_controller.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  // --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Image section
            Expanded(
              flex: 1,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.onboardingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: Get.height * 0.55,
                            width: Get.width,
                            child: Image.asset(
                              controller.onboardingData[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 50, // Adjust top position as needed
                            right: 16, // Adjust right position as needed
                            child: appButtonView(
                              textSize: AppDimensions.FONT_SIZE_14,
                              buttonName: 'Skip',
                              onTap: controller.nextPage,
                              textColor: AppColors.PRIMARY_COLOR,
                              buttonColor: AppColors.BG_1,
                              buttonWidth: 70,
                              buttonHeight: 30,
                              borderWidth: 1,
                              borderColor: AppColors.PRIMARY_COLOR,
                            ),
                          ),
                        ],
                      ),
                      // Slider dots
                      Obx(
                        () => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: buildDotIndicators(context),
                            ),
                            SizedBox(
                              // color: AppColors.PARROT,
                              height: Get.height * 0.22,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  appTextView(
                                    text:
                                        controller.onboardingData[index].title,
                                    color: AppColors.BLACK,
                                    size: AppDimensions.FONT_SIZE_20,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w600,
                                    // isStroke: false,
                                  ),

                                  const SizedBox(height: 18),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: appTextView(
                                      text: controller
                                          .onboardingData[index]
                                          .description,
                                      color: AppColors.TEXT_1,
                                      size: AppDimensions.FONT_SIZE_14,
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.center,

                                      // isStroke: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Next button
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: appButtonView(
                buttonName:
                    controller.currentPage.value ==
                        controller.onboardingData.length - 1
                    ? 'Get Started'
                    : 'Next',
                onTap: controller.nextPage,
                textColor: AppColors.WHITE,
                buttonColor: AppColors.PRIMARY_COLOR,
                buttonWidth: Get.width,
                borderWidth: 8,
                borderColor: AppColors.PRIMARY_COLOR,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appTextView(
                    text: 'See Virtual Try-On in Action ',
                    size: AppDimensions.FONT_SIZE_12,
                    fontFamily: 'Roboto',
                    // color: AppColors.BLACK,
                    // fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppGlobal.instance.openLink(AppConstants.virtualTryDemo);
                    },
                    child: appTextView(
                      text: 'Try Demo',
                      size: AppDimensions.FONT_SIZE_12,
                      fontFamily: 'Roboto',
                      color: AppColors.PRIMARY_COLOR,
                      underLine: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDotIndicators(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(controller.onboardingData.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: controller.currentPage.value == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: controller.currentPage.value == index
                ? const Color.fromRGBO(247, 127, 0, 1)
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
