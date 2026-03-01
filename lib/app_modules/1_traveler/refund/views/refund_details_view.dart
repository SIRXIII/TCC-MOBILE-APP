import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/controllers/refund_controller.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/cacheImage/app_image_view.dart';
import 'package:travel_clothing_club_flutter/utils/constants/firebase_constants.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

class RefundDetailsView extends StatefulWidget {
  const RefundDetailsView({super.key});

  @override
  State<RefundDetailsView> createState() => _RefundDetailsViewState();
}

class _RefundDetailsViewState extends State<RefundDetailsView> {
  // --> PROPERTIES
  final RefundController controller = Get.find<RefundController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBarView(title: 'Refund Details'),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomActions(),
      key: _scaffoldKey,
    );
  }

  Widget _buildBody() {
    var refundData = controller.selectedRefund;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    appTextView(
                      text: refundData.getRefundId(),
                      size: AppDimensions.FONT_SIZE_16,
                      fontFamily: 'Roboto',
                      color: AppColors.BLACK,
                      fontWeight: FontWeight.w600,
                    ),
                    Spacer(),
                    appTextView(
                      text: refundData.getRequestedAt(),
                      size: AppDimensions.FONT_SIZE_12,
                      fontFamily: 'Roboto',
                      color: AppColors.TEXT_1,
                      // fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _headerView(
                          title: 'Order ID',
                          value: refundData.order?.getOrderId() ?? '',
                        ),
                        const SizedBox(height: 12),
                        _headerView(
                          title: 'Item:',
                          value: refundData.order!.items?[0].getName() ?? '',
                        ),
                        const SizedBox(height: 12),
                        _headerView(title: 'Payment:', value: 'Stripe'),
                        const SizedBox(height: 12),
                        _headerView(title: 'Address:', value: 'Lahore'),

                        const SizedBox(height: 12),
                        _headerView(
                          title: 'Return Due Date:',
                          value:
                              refundData.order!.items?[0].getReturnDueDate() ??
                              '',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.WHITE,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppCacheImageView(
                        imageUrl: refundData.order!.items?[0].getImage() ?? '',
                        height: Get.height * 0.12,
                        width: Get.width * 0.25,
                        boxFit: BoxFit.cover,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              child: appTextView(
                                text:
                                    refundData.order!.items?[0].getName() ?? '',
                                size: AppDimensions.FONT_SIZE_16,
                                fontFamily: 'Roboto',
                                color: AppColors.BLACK,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            appTextView(
                              text:
                                  'Size: ${refundData.order!.items?[0].getSize()}',
                              size: AppDimensions.FONT_SIZE_12,
                              fontFamily: 'Roboto',
                              color: AppColors.BLACK,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: Get.width * 0.58,
                              child: Row(
                                children: [
                                  appTextView(
                                    text: 'Rental Duration: ',
                                    size: AppDimensions.FONT_SIZE_12,
                                    fontFamily: 'Roboto',
                                    color: AppColors.BLACK.withValues(
                                      alpha: 0.6,
                                    ),
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  appTextView(
                                    text:
                                        '${refundData.order!.items?[0].getRentalDays()}',
                                    size: AppDimensions.FONT_SIZE_12,
                                    fontFamily: 'Roboto',
                                    color: AppColors.BLACK,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  Spacer(),
                                  appTextView(
                                    text:
                                        '\$${refundData.order!.getTotalPrice()} ',
                                    size: AppDimensions.FONT_SIZE_16,
                                    fontFamily: 'Roboto',
                                    color: AppColors.PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerView({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appTextView(
          text: title,
          size: AppDimensions.FONT_SIZE_14,
          fontFamily: 'Roboto',
          color: AppColors.TEXT_1,
          // fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 6),
        appTextView(
          text: value,
          size: AppDimensions.FONT_SIZE_16,
          fontFamily: 'Roboto',
          color: AppColors.BLACK.withValues(alpha: 0.7),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    var refundData = controller.selectedRefund;
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: CustomButton(
        text: 'Chat with Partner',
        height: 40,
        onPressed: () {
          // Get.toNamed(AppRoutes.travelerDashboardWithParam(userId: '11'));

          Get.toNamed(
            AppRoutes.travelerChat,
            parameters: {
              FirebaseConstants.receiverId: controller.selectedRefund
                  .getRefundId(),
              FirebaseConstants.receiverName:
                  controller.selectedRefund.partner?.getName() ?? '',
            },
          );

          // Get.to(() => ChatConversationView(receiverId: '11'));
          // Get.to(() => ChatScreen(receiverId: '11', receiverName: 'Asim'));
          // Get.toNamed(AppRoutes.travelerChat);
          // Get.toNamed(AppRoutes.chatSupport);
        },
      ),
    );
  }
}
