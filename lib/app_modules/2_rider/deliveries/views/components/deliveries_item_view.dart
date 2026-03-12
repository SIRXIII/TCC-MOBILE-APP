import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/order_status.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/controllers/deliveries_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/model/rider_deliveries_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/feedback/feedback_botttom_sheet_view.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';

import '../../../../../utils/app_imports.dart';

Widget deliveriesItemView(Deliveries order) {
  final DeliveriesController controller = Get.find();

  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: AppColors.WHITE,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: InkWell(
      onTap: () {
        AppLogger.debugPrintLogs('isReturnsOrder', order.isReturnsOrder());
        AppGlobal.instance.setSelectedDelivery = order;
        Get.toNamed(AppRoutes.riderDeliveriesDetails);

        // Get.toNamed(AppRoutes.orderTracking);
        // controller.navigateToOrderTracking(order);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            // color: AppRoutespColors.PARROT,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spa,
                children: [
                  ClipOval(
                    child: AppCacheImageView(
                      imageUrl: order.getTravelerPhoto(),
                      boxFit: BoxFit.cover,
                      height:
                          30, // make sure width = height for a perfect circle
                      width: 30,
                      isProfile: true,
                      // fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  appTextView(
                    text: order.getTravelerName(),
                    color: AppColors.BLACK,
                    size: AppDimensions.FONT_SIZE_14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),

                  // order.traveler == null
                  //     ? SizedBox.shrink()
                  //     : InkWell(
                  //         onTap: () {
                  //           debugPrint(
                  //             'Chat with traveler --> ${order.getOrderId()} - ${order.traveler?.getId() ?? ''}',
                  //           );
                  //
                  //           AppGlobal.instance.chatWith = 'Traveler';
                  //           AppGlobal.instance.orderId = order.getOrderId();
                  //           AppGlobal.instance.chatWithName =
                  //               order.traveler?.getName() ?? '';
                  //
                  //           Get.toNamed(
                  //             AppRoutes.orderChat,
                  //             arguments: {
                  //               FirebaseConstants.orderId: order.getOrderId(),
                  //               // "currentUserId": user.id,
                  //               FirebaseConstants.receiverId:
                  //                   order.traveler?.getId() ?? '',
                  //             },
                  //           );
                  //         },
                  //
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 8.0),
                  //           child: Icon(
                  //             Icons.chat_rounded,
                  //             color: AppColors.PRIMARY_COLOR,
                  //             size: 20,
                  //           ),
                  //         ),
                  //       ),
                  Spacer(),
                  SizedBox(
                    // color: AppColors.PRIMARY_COLOR,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: appTextView(
                        textAlign: TextAlign.end,
                        text: order.getOrderId(),
                        color: AppColors.BLACK,
                        size: AppDimensions.FONT_SIZE_14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                order.getPickupBy() == ''
                    ? SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgIconWidget(assetName: AppImages.icPickupBy),
                              appTextView(
                                text: 'Pickup by:',
                                size: AppDimensions.FONT_SIZE_12,
                                fontFamily: 'Poppins',
                                // fontWeight: FontWeight.w500,
                                color: AppColors.TEXT_1,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: appTextView(
                              // textAlign: TextAlign.end,
                              text: order.getPickupBy(),
                              color: AppColors.BLACK,
                              size: AppDimensions.FONT_SIZE_14,
                              fontFamily: 'Roboto',
                              // fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    children: [
                      SvgIconWidget(assetName: AppImages.icPickup, size: 20),
                      appTextView(
                        text: ' Pickup:',
                        size: AppDimensions.FONT_SIZE_12,
                        fontFamily: 'Poppins',
                        // fontWeight: FontWeight.w500,
                        color: AppColors.TEXT_1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: appTextView(
                    // textAlign: TextAlign.end,
                    text: order.partner?.getAddress() ?? '',
                    color: AppColors.BLACK,
                    size: AppDimensions.FONT_SIZE_14,
                    fontFamily: 'Roboto',
                    // fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    children: [
                      SvgIconWidget(assetName: AppImages.icPickup, size: 20),
                      appTextView(
                        text: ' Drop off:',
                        size: AppDimensions.FONT_SIZE_12,
                        fontFamily: 'Poppins',
                        // fontWeight: FontWeight.w500,
                        color: AppColors.TEXT_1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: appTextView(
                    // textAlign: TextAlign.end,
                    text: order.traveler?.getAddress() ?? '',
                    color: AppColors.BLACK,
                    size: AppDimensions.FONT_SIZE_14,
                    fontFamily: 'Roboto',
                    // fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),

          Obx(() {
            return controller.selectedTabIndex.value == 2
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: appButtonView(
                      textSize: 13,
                      buttonHeight: 35,
                      buttonWidth: Get.width,
                      buttonName: 'Add Rating',
                      buttonColor: AppColors.PRIMARY_COLOR,
                      textColor: AppColors.WHITE,
                      fontWeight: FontWeight.w600,
                      onTap: () {
                        Get.bottomSheet(
                          FeedbackBottomSheetView(deliveries: order),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        ).whenComplete(() {
                          controller.resetFeedbackData();
                          // 🔥 Your close logic here
                          // controller.clearFeedback();
                          // refresh something
                        });
                      },
                    ),
                  )
                : controller.updateOrderStatusByOrderIdLoader.isTrue
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: appLoaderView(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: appButtonView(
                      textSize: 13,
                      buttonHeight: 35,
                      buttonWidth: Get.width,
                      buttonName: controller.selectedTabIndex.value == 0
                          ? 'Mark as Picked Up'
                          : 'Mark as Delivered',
                      buttonColor: AppColors.PRIMARY_COLOR,
                      textColor: AppColors.WHITE,
                      fontWeight: FontWeight.w600,
                      onTap: () {
                        // update status Shipped

                        String status = '';
                        if (controller.selectedTabIndex.value == 0) {
                          status = OrderStatus.shipped.name;
                        } else if (controller.selectedTabIndex.value == 1) {
                          status = OrderStatus.delivered.name;
                        }

                        if (controller.selectedTabIndex.value == 2) {}
                        controller.updateOrderStatusByOrderId(
                          order.id.toString(),
                          status,
                        );
                      },
                    ),
                  );
          }),
        ],
      ),
    ),
  );
}
