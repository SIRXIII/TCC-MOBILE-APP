import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/controllers/support_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/views/components/support_tickets_sheet_view.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

class CreateRiderSupportTicketView extends StatelessWidget {
  CreateRiderSupportTicketView({super.key});

  /// --> Properties
  final RiderSupportController supportController =
      Get.find<RiderSupportController>();

  /// --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: appBarView(title: 'Create Support Ticket'),
      body: _buildBody(),
    );
  }

  /// --> build Body
  Widget? _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          spacing: 24,
          children: [
            // SizedBox(height: 2),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CustomTextField(
                  label: 'Select Ticket Type',
                  hintText: 'Select ticket type',
                  controller: TextEditingController(
                    text: supportController.selectedTicketType == null
                        ? ''
                        : supportController.selectedTicketType ?? '',
                  ),
                  // keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                  onTap: () {
                    supportTicketsSelectionSheet();
                  },
                ),
              ),
            ),

            TextFormField(
              textInputAction: TextInputAction.done,
              controller: supportController.descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Describe your issue in detail...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please describe the issue';
                }
                if (value.length < 10) {
                  return 'Please provide more details (at least 10 characters)';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            Obx(
              () => CustomButton(
                text: supportController.addSupportTicketApiRequestLoader.isFalse
                    ? 'Submit Support Ticket'
                    : 'Submitting Support Ticket Request...',
                height: 40,
                onPressed: () {
                  supportController.addSupportTicketApiRequest();
                },
                isEnabled:
                    supportController.addSupportTicketApiRequestLoader.isFalse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
