import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/controllers/traveler_orders_controller.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

final TravelerOrdersController controller = Get.find();

void selectReturnTypeSheetView() {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(
        top: 8,
        left: 16.0,
        right: 16.0,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              width: 50,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Center(
            child: appTextView(
              text: 'Select',
              size: AppDimensions.FONT_SIZE_16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildFilterOption('Completed'),
          _buildFilterOption('Returned'),
          _buildFilterOption('Refunded'),
          _buildFilterOption('Canceled'),

          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

Widget _buildFilterOption(String title) {
  return InkWell(
    onTap: () {
      controller.selectedReturnType.value = title;
      Get.back();
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Obx(
            () => controller.selectedReturnType.value == title
                ? const Icon(Icons.check, color: Colors.green)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    ),
  );
}
