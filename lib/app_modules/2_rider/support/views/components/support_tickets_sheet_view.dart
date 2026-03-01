import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/controllers/support_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/model/support_ticket.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

final RiderSupportController supportController =
    Get.find<RiderSupportController>();

void supportTicketsSelectionSheet() {
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
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
              child: appTextView(
                text: 'Select ticket type',
                size: AppDimensions.FONT_SIZE_16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(
            height: 300, // or MediaQuery height
            child: ListView.builder(
              itemCount: TicketCategory.values.length,
              itemBuilder: (context, index) {
                return _buildFilterOption(
                  TicketCategory.values[index].displayName,
                );
              },
            ),
          ),
          // _buildFilterOption('Completed'),
          const SizedBox(height: 18),

          // _buildSectionHeader('Supporting Images (Optional)'),
        ],
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  );
}

Widget _buildFilterOption(String title) {
  return Obx(() {
    bool isSelected = supportController.selectedTicketType == title;

    return InkWell(
      onTap: () {
        supportController.setSelectedTicketType(title);

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
              title,
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
