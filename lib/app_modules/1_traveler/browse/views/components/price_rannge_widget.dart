import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/browse/controllers/filter_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/controllers/traveler_home_controller.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

class PriceRangeWidget extends StatelessWidget {
  final FilterController controller = Get.put(FilterController());
  final TravelerHomeController travelerHomeController = Get.find();
  PriceRangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final sizes = ['Small', 'Medium', 'Large'];

    return Container(
      color: Colors.white,
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextView(
            text: 'Price Range',
            size: AppDimensions.FONT_SIZE_16,
            fontFamily: 'Roboto',
            color: AppColors.BLACK,
            fontWeight: FontWeight.w600,
          ),

          // PRICE RANGE SECTION
          const SizedBox(height: 16),
          Obx(() {
            // controller.setPriceRange(
            //   RangeValues(
            //     double.parse(
            //       travelerHomeController.filterOptions.priceRange!.min!,
            //     ),
            //     double.parse(
            //       travelerHomeController.filterOptions.priceRange!.max!,
            //     ),
            //   ),
            // );
            final range = controller.priceRange.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RangeSlider(
                  values: range,
                  min: 5,
                  max: 500,
                  activeColor: Colors.orange,
                  inactiveColor: Colors.orange.withOpacity(0.3),
                  divisions: 50,
                  onChanged: (newRange) {
                    controller.priceRange.value = newRange;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${travelerHomeController.filterOptions.priceRange!.min!}',
                      style: TextStyle(color: Colors.orange),
                    ),
                    Text(
                      '\$${travelerHomeController.filterOptions.priceRange!.max!}',
                      style: TextStyle(color: Colors.orange),
                    ),
                    // Text('\$35', style: TextStyle(color: Colors.orange)),
                    // Text('\$200', style: TextStyle(color: Colors.orange)),
                    // Text('\$500', style: TextStyle(color: Colors.orange)),
                  ],
                ),
              ],
            );
          }),

          // const SizedBox(height: 24),
        ],
      ),
    );
  }
}
