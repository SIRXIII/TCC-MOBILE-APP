import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/controllers/product_details_controller.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

class RentalDaysSelectorView extends StatelessWidget {
  final int minRental;
  final int maxRental;

  RentalDaysSelectorView({
    super.key,
    required this.minRental,
    required this.maxRental,
  });

  final ProductDetailsController controller = Get.find();

  // --> build
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appTextView(
              text: 'Rental Days:',
              size: AppDimensions.FONT_SIZE_14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),

            const SizedBox(height: 12),

            Obx(() {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate((maxRental - minRental) + 1, (index) {
                  int number = minRental + index;
                  bool isSelected =
                      controller.selectedRentalDayValue.value == number;

                  return GestureDetector(
                    onTap: () {
                      controller.selectRentalDayValue(number);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.PRIMARY_COLOR
                            : AppColors.PRIMARY_COLOR.withOpacity(0.1),
                        shape: BoxShape.rectangle,
                        borderRadius: AppBorderRadius.BORDER_RADIUS_8,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.PRIMARY_COLOR
                              : AppColors.PRIMARY_COLOR.withOpacity(0.3),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        number.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? AppColors.WHITE
                              : Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
