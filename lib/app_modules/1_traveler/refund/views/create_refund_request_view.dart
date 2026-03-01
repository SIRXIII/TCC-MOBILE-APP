// views/create_refund_request_view.dart

import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/controllers/traveler_orders_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/views/widgets/order_selection_sheet.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/views/widgets/refund_reason_selection_sheet.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/views/widgets/refund_reasons_sheet.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import '../../orders/models/orders_api_response.dart';
import '../controllers/refund_controller.dart';
import '../models/refund_request_model.dart';

class CreateRefundRequestView extends StatefulWidget {
  const CreateRefundRequestView({super.key});

  @override
  State<CreateRefundRequestView> createState() =>
      _CreateRefundRequestViewState();
}

class _CreateRefundRequestViewState extends State<CreateRefundRequestView> {
  final RefundController controller = Get.find<RefundController>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _orderIdController = TextEditingController();
  final TextEditingController _orderItemController = TextEditingController();

  final TravelerOrdersController travelerOrdersController = Get.find();

  RefundReason _selectedReason = RefundReason.other;
  final List<RefundReason> _reasons = RefundReason.values;
  final AppGlobal _appGlobal = AppGlobal.instance;

  @override
  void initState() {
    super.initState();
    // Pre-fill with sample data for demo
    _orderIdController.text = '';
    _orderItemController.text = '';
    controller.amountController.text = '';

    if (_appGlobal.getSelectedOrder != Order()) {
      controller.setSelectedOrder(_appGlobal.getSelectedOrder);
    }
    // controller.setSelectedOrder(AppGlobal.instance.)
  }

  // --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        title: appTextView(
          text: 'Create Refund',
          color: AppColors.BLACK,
          size: AppDimensions.FONT_SIZE_18,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          // isStroke: false,
        ),
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgIconWidget(assetName: AppImages.icBack),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Information
              _buildSectionHeader('Order Information'),
              const SizedBox(height: 16),

              Obx(
                () => CustomTextField(
                  label: 'Order ID',
                  hintText: 'Select your order ID',
                  controller: TextEditingController(
                    text:
                        controller.selectedOrder!.getOrderId().contains('null')
                        ? ''
                        : controller.selectedOrder?.getOrderId() ?? '',
                  ),
                  // keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                  onTap: () {
                    orderSelectionSheet();
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CustomTextField(
                  label: 'Reason For Refund',
                  hintText: 'Select Refund Reason',
                  controller: TextEditingController(
                    text: controller.selectedReason!.isEmpty
                        ? ''
                        : controller.selectedReason,
                  ),
                  // keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                  onTap: () {
                    refundReasonSheet(refundController: controller);
                  },
                ),
              ),

              const SizedBox(height: 18),

              CustomTextField(
                label: 'Refund Amount',
                hintText: 'Enter refund amount',
                controller: controller.amountController,
                // keyboardType: TextInputType.number,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),

              const SizedBox(height: 18),

              // Refund Reason - Now using bottom sheet
              _buildSectionHeader('Refund Reason'),
              const SizedBox(height: 12),

              // CustomTextField(
              //   label: 'Reason',
              //   hintText: 'Enter reason for refund',
              //   controller: _descriptionController,
              //   keyboardType: TextInputType.text,
              // ),
              //
              // _buildReasonSelectionField(),
              // const SizedBox(height: 24),

              // Description
              // _buildSectionHeader('Description'),
              // const SizedBox(height: 12),
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Describe the issue in detail',
                  hintText:
                      'Please provide detailed information about why you are requesting a refund...',
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
              const SizedBox(height: 32),

              // Upload Images
              _buildSectionHeader('Supporting Images (Optional)'),
              const SizedBox(height: 12),

              _buildImageUploadSection(),
              const SizedBox(height: 32),

              // Submit Button
              Obx(
                () => CustomButton(
                  text: controller.createRefundApiRequestLoader.isFalse
                      ? 'Submit Refund Request'
                      : 'Submitting Request...',
                  height: 40,
                  onPressed: () {
                    controller.createRefundApiRequest();
                  },
                  isEnabled: controller.createRefundApiRequestLoader.isFalse,
                ),
              ),
            ],
          ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildReasonSelection() {
    return Column(
      children: _reasons.map((reason) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: RadioListTile<RefundReason>(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reason.displayText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reason.description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            value: reason,
            groupValue: _selectedReason,
            onChanged: (RefundReason? value) {
              setState(() {
                _selectedReason = value!;
              });
            },
          ),
        );
      }).toList(),
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
        Text(
          'Upload images that show the issue (max 5 images)',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
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

  void _openReasonSelectionSheet() {
    Get.bottomSheet(
      RefundReasonSelectionSheet(
        selectedReason: _selectedReason,
        onReasonSelected: (reason) {
          setState(() {
            _selectedReason = reason;
          });
          Get.back();
        },
      ),
      // isScrollControlled: true,
      backgroundColor: AppColors.background,
      enableDrag: true, // Optional: allows dragging to dismiss
      isDismissible: true, // Optional: allows dismissing by tapping outside
    );
  }
}
