import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/controllers/refund_controller.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

// final TravelerOrdersController controller = Get.find();
// final RefundController refundController = Get.find();

void refundReasonSheet({required RefundController refundController}) {
  // final RefundController refundController = Get.find<RefundController>();

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
              text: 'Select Reason For Refund',
              size: AppDimensions.FONT_SIZE_16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 300, // or MediaQuery height
            child: ListView.builder(
              itemCount: refundController.reasonsForRefund.length,
              itemBuilder: (context, index) {
                return _buildFilterOption(
                  refundController.reasonsForRefund[index],
                  refundController: refundController,
                );
              },
            ),
          ),
          // _buildFilterOption('Completed'),
          const SizedBox(height: 18),
        ],
      ),
    ),
  );
}

Widget _buildFilterOption(
  String reason, {
  required RefundController refundController,
}) {
  return Obx(() {
    bool isSelected = refundController.selectedReason == reason;

    return InkWell(
      onTap: () {
        refundController.setSelectedReason(reason);

        // controller.selectedOrder.value = title;
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.orange.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.orange.withOpacity(0.4),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              reason,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.orange : Colors.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (isSelected) const Icon(Icons.check, color: Colors.orange),
          ],
        ),
      ),
    );
  });
}
