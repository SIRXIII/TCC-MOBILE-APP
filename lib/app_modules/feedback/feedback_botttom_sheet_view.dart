// views/filter_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/controllers/deliveries_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/model/rider_deliveries_api_response.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/loader/app_loader.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

class FeedbackBottomSheetView extends StatelessWidget {
  final Deliveries deliveries;
  FeedbackBottomSheetView({required this.deliveries, super.key});

  final DeliveriesController controller = Get.find();

  /// --> build
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        spacing: 6,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          // Header
          _buildHeader(),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  RatingSelector(),
                  const SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: controller.feedBackReviewController.value,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Review',
                      hintText: 'Add your review',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignLabelWithHint: true,
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please describe the issue';
                    //   }
                    //   if (value.length < 10) {
                    //     return 'Please provide more details (at least 10 characters)';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 8),
                  Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Upload Image (Optional)'),
                      _buildImageUploadSection(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Bottom Buttons
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appTextView(
            text: 'Your Feedback Means A lot',
            size: AppDimensions.FONT_SIZE_18,
            fontFamily: 'Roboto',
            color: AppColors.BLACK,
            fontWeight: FontWeight.bold,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: appTextView(
              textAlign: TextAlign.center,
              text:
                  'Share your Experience with us. What\'s working well? what could\'ve gone better',
              size: AppDimensions.FONT_SIZE_14,
              fontFamily: 'Roboto',
              color: AppColors.TEXT_1,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.selectedImages.isEmpty) {
            return _buildUploadButton();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selected Images Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: controller.selectedImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      // Image
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(controller.selectedImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Remove Button
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => controller.removeImage(index),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              // Add More Button
              _buildUploadButton(),
            ],
          );
        }),

        const SizedBox(height: 8),
        // Text(
        //   'Upload images that show the issue (max 5 images)',
        //   style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        // ),
      ],
    );
  }

  Widget _buildUploadButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => controller.pickImages(),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: AppColors.PRIMARY_COLOR),
        ),
        icon: Icon(Icons.cloud_upload, color: AppColors.PRIMARY_COLOR),
        label: Text(
          'Upload Images',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.PRIMARY_COLOR,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Divider(height: 1, color: Color(0xFFE5E5E5)),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Obx(() {
        return controller.addFeedbackReviewApiRequestLoader.isTrue
            ? Padding(
                padding: EdgeInsets.only(
                  bottom: GetPlatform.isAndroid ? 4.0 : 18.0,
                ),
                child: Center(child: appLoaderView()),
              )
            : Padding(
                padding: EdgeInsets.only(
                  bottom: GetPlatform.isAndroid ? 4.0 : 18.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: appButtonView(
                        textSize: 14,
                        buttonHeight: 35,
                        buttonWidth: Get.width,
                        buttonName: 'Skip',
                        buttonColor: AppColors.TRANSPARENT,
                        textColor: AppColors.PRIMARY_COLOR,
                        borderColor: AppColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.w600,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        text: 'Submit',
                        height: 40,
                        onPressed: () {
                          // TODO: Hit review API

                          controller.addFeedbackReviewApiRequest(
                            deliveries.id.toString(),
                            deliveries.rider?.getId() ?? '',
                            deliveries.traveler?.getId() ?? '',
                          );
                          // Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}

class RatingSelector extends StatelessWidget {
  final DeliveriesController controller = Get.find();

  RatingSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          int starIndex = index + 1;

          return GestureDetector(
            onTap: () => controller.selectRating(starIndex),
            child: Icon(
              controller.selectedRating.value >= starIndex
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              size: Get.width * 0.12,
              color: controller.selectedRating.value >= starIndex
                  ? AppColors.PRIMARY_COLOR
                  : Colors.grey,
            ),
          );
        }),
      );
    });
  }
}
