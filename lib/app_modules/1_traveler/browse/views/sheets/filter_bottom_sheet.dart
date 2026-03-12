// views/filter_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/browse/controllers/filter_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/browse/views/components/price_rannge_widget.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/controllers/traveler_home_controller.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({super.key});

  // final FilterController controller = Get.find<FilterController>();
  final FilterController controller = Get.put(FilterController());
  final TravelerHomeController travelerHomeController = Get.find();

  // --> build
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRentalDurationSection(),
                  _buildDivider(),
                  _brandsList(),

                  // _buildBrandsSection(),
                  _buildDivider(),
                  RatingFilterWidget(),
                  // _buildRatingSection(),
                  _buildDivider(),
                  _buildSizeSection(),
                  _buildDivider(),
                  PriceRangeWidget(),
                  // _buildPriceRangeSection(),
                  const SizedBox(height: 80), // Space for bottom buttons
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          appTextView(
            text: 'Filters',
            size: AppDimensions.FONT_SIZE_18,
            fontFamily: 'Roboto',
            color: AppColors.BLACK,
            fontWeight: FontWeight.bold,
          ),

          TextButton(
            onPressed: () async {
              controller.resetFilters();

              await Future.delayed(const Duration(milliseconds: 200));
              travelerHomeController.productsApiRequest();
            },
            child: appTextView(
              text: 'Clear',
              size: AppDimensions.FONT_SIZE_16,
              fontFamily: 'Roboto',
              color: AppColors.PRIMARY_COLOR,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxItem(String label, bool value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: value ? Colors.black : Colors.grey.shade400,
                width: 2,
              ),
              color: value ? Colors.black : Colors.transparent,
            ),
            child: value
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: value ? Colors.black : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Divider(height: 1, color: Color(0xFFE5E5E5)),
    );
  }

  Widget _buildRentalDurationSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextView(
            text: 'Rental Duration',
            size: AppDimensions.FONT_SIZE_16,
            fontFamily: 'Roboto',
            color: AppColors.BLACK,
            fontWeight: FontWeight.w600,
          ),
          // Text(
          //   'Rental Duration',
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 12),
          Obx(() {
            final min = int.parse(
              travelerHomeController.filterOptions.rentalPeriodRange!
                  .getMinRental(),
            );
            final max = int.parse(
              travelerHomeController.filterOptions.rentalPeriodRange!
                  .getMaxRental(),
            );
            final durations = List.generate(
              max - min + 1,
              (i) => '${min + i} days',
            );

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: durations.map((duration) {
                  final isSelected =
                      controller.filters.value.rentalDuration == duration;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildChip(
                      duration,
                      isSelected,
                      () => controller.setRentalDuration(duration),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSizeSection() {
    final sizes = travelerHomeController.filterOptions.sizes ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTextView(
          text: 'Size',
          size: AppDimensions.FONT_SIZE_16,
          fontFamily: 'Roboto',
          color: AppColors.BLACK,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: sizes.map((size) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Obx(() {
                  return _buildChip(
                    size,
                    controller.filters.value.size == size,
                    () => controller.setSize(size),
                  );
                }),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _brandsList() {
    final brands = travelerHomeController.filterOptions.brands ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTextView(
          text: 'Brands',
          size: AppDimensions.FONT_SIZE_16,
          fontFamily: 'Roboto',
          color: AppColors.BLACK,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: brands.map((brand) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Obx(() {
                  return _buildChip(
                    brand,
                    controller.filters.value.selectedBrands.contains(brand),
                    () => controller.toggleBrand(brand),
                  );
                }),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.PRIMARY_COLOR : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(
          //   color: isSelected ? Colors.black : Colors.grey.shade300,
          // ),
        ),
        child: appTextView(
          text: label,
          size: AppDimensions.FONT_SIZE_14,
          fontFamily: 'Roboto',
          color: isSelected ? Colors.white : Colors.grey.shade700,
          fontWeight: FontWeight.w400,
        ),
        // Text(
        //   label,
        //   style: TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //     color: isSelected ? Colors.white : Colors.grey.shade700,
        //   ),
        // ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
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
      child: Row(
        children: [
          /* Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),*/
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: GetPlatform.isAndroid ? 4.0 : 18.0,
              ),
              child: CustomButton(
                text: 'Apply',
                height: 40,
                onPressed: () {
                  AppLogger.debugPrintLogs(
                    'Applied Filter',
                    controller.filters.toString(),
                  );
                  travelerHomeController.productsApiRequest(
                    filterModel: controller.filters.value,
                  );
                  Get.back();
                },
              ),
            ),
            /*ElevatedButton(
              onPressed: () {
                AppLogger.debugPrintLogs(
                  'Applied Filter',
                  controller.filters.toString(),
                );
                travelerHomeController.productsApiRequest(
                  filterModel: controller.filters.value,
                );
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.PRIMARY_COLOR,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),*/
          ),
        ],
      ),
    );
  }
}

class RatingFilterWidget extends StatelessWidget {
  final FilterController controller = Get.find<FilterController>();

  RatingFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ratings = [4, 3, 2, 1]; // Example rating levels

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTextView(
          text: 'Rating',
          size: AppDimensions.FONT_SIZE_16,
          fontFamily: 'Roboto',
          color: AppColors.BLACK,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 12),
        Obx(
          () => Column(
            children: ratings.map((rating) {
              return RadioListTile<int>(
                value: rating,
                groupValue: controller.selectedRating.value,
                onChanged: (value) {
                  controller.setRating(value!.toDouble());
                  controller.selectedRating.value = value;
                },
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                activeColor: Colors.orange,
                title: Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: index < rating ? Colors.orange : Colors.grey,
                          size: 20,
                        );
                      }),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '& up',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
