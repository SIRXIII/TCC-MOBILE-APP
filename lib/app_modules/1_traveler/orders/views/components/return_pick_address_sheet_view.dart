import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/controllers/traveler_orders_controller.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

import '../../models/orders_api_response.dart';

void returnPickAddressBottomSheet({required Order order}) {
  final TextEditingController addressController = TextEditingController(
    text: order.traveler?.getAddress() ?? '',
  );
  final Rx<DateTime?> selectedTime = Rx<DateTime?>(null);

  final TravelerOrdersController controller = Get.put(
    TravelerOrdersController(),
  );
  Get.bottomSheet(
    Container(
      height: Get.height * 0.4,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16.0, bottom: 20, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Top drag handle
          Center(
            child: Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // --- Title
          appTextView(
            textAlign: TextAlign.center,
            text: 'Enter Return Pick Address and Time',
            size: AppDimensions.FONT_SIZE_16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),

          // const Text(
          //   "Enter Return Pick Address and Time",
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          // ),
          const SizedBox(height: 24),

          // --- Address Field
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: "Enter Address",
              // prefixIcon: const Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // --- Time Picker Field
          Obx(() {
            final time = selectedTime.value;
            return InkWell(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  final pickedTime = await showTimePicker(
                    context: Get.context!,
                    initialTime: TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    selectedTime.value = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                  }
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: "Time",
                  // prefixIcon: const Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
                child: Text(
                  time != null
                      ? DateFormat('MMM dd, yyyy – hh:mm a').format(time)
                      : "Tap to pick time",
                  style: TextStyle(
                    color: time == null ? Colors.grey.shade500 : Colors.black87,
                  ),
                ),
              ),
            );
          }),

          const Spacer(),

          // --- Confirm Button
          Padding(
            padding: EdgeInsets.only(
              bottom: GetPlatform.isAndroid ? 4.0 : 18.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Obx(
                () => CustomButton(
                  text: controller.requestReturnApiRequestLoader.isFalse
                      ? 'Request Return'
                      : 'Requesting Return...',
                  height: 40,
                  onPressed: () {
                    controller.requestReturnApiRequest(
                      addressController.text,
                      selectedTime.value.toString(),
                      order,
                    );
                    debugPrint("Selected Address: ${addressController.text}");
                    debugPrint("Selected Time: ${selectedTime.value}");
                  },
                  isEnabled: controller.requestReturnApiRequestLoader.isFalse,
                ),
              ),
              /*  ElevatedButton(
                onPressed: () {
                  if (addressController.text.isEmpty ||
                      selectedTime.value == null) {
                    appToastView(title: 'Please enter address and pick a time');

                    // Get.snackbar(
                    //   "Incomplete",
                    //   "Please enter address and pick a time.",
                    //   snackPosition: SnackPosition.BOTTOM,
                    // );
                    return;
                  }
                  onConfirm(addressController.text, selectedTime.value!);
                  // Get.back(); // close bottom sheet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PRIMARY_COLOR,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Schedule",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),*/
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
