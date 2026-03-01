import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/order_status.dart';

import '../../../../../utils/app_imports.dart';
import '../../models/orders_api_response.dart';

Widget travelerOrdersItemView(Order order) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: AppColors.WHITE,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: InkWell(
      onTap: () {
        AppGlobal.instance.setSelectedOrder = order;
        Get.toNamed(AppRoutes.orderTracking);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppCacheImageView(
            imageUrl: order.items?[0].getImage() ?? '',
            height: Get.height * 0.128,
            width: Get.width * 0.25,
            boxFit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * 0.64,
                  // color: AppColors.PRIMARY_COLOR,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appTextView(
                        text: ' ${order.items?[0].getName()}',
                        size: AppDimensions.FONT_SIZE_14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      // Spacer(),
                      // order.rider == null
                      //     ? SizedBox.shrink()
                      //     : InkWell(
                      //         onTap: () {
                      //           debugPrint(
                      //             'Chat with Rider --> ${order.getOrderIdName()} - ${order.rider?.getId()}',
                      //           );
                      //
                      //           AppGlobal.instance.chatWith = 'Rider';
                      //           AppGlobal.instance.chatWithName =
                      //               order.rider?.getName() ?? '';
                      //           AppGlobal.instance.orderId = order
                      //               .getOrderIdName();
                      //
                      //           Get.toNamed(
                      //             AppRoutes.orderChat,
                      //             arguments: {
                      //               // FirebaseConstants.orderId: order
                      //               //     .getOrderIdName()
                      //               //     .toString(),
                      //               // "currentUserId": user.id,
                      //               FirebaseConstants.receiverId:
                      //                   order.rider?.getRiderId() ?? '',
                      //             },
                      //           );
                      //
                      //           // Get.toNamed(
                      //           //   AppRoutes.travelerChat,
                      //           //   parameters: {
                      //           //     FirebaseConstants.receiverId: order
                      //           //         .getOrderIdName(),
                      //           //     FirebaseConstants.receiverName:
                      //           //         order.rider?.getName() ?? '',
                      //           //   },
                      //           // );
                      //         },
                      //         child: Icon(
                      //           Icons.chat_rounded,
                      //           color: AppColors.PRIMARY_COLOR.withValues(
                      //             alpha: 0.8,
                      //           ),
                      //           size: 18,
                      //         ),
                      //       ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: OrderStatus.getStatusColor(
                        order.getStatus(),
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: OrderStatus.getStatusColor(
                          order.getStatus(),
                        ).withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      OrderStatus.getStatusText(order.getStatus()),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: OrderStatus.getStatusColor(order.getStatus()),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: Get.width * 0.62,
                    // color: AppColors.PARROT,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        appTextView(
                          text: 'Return Due:',
                          size: AppDimensions.FONT_SIZE_12,
                          fontFamily: 'Poppins',
                          // fontWeight: FontWeight.w600,
                        ),

                        appTextView(
                          text: ' ${order.items?[0].getReturnDueDate()}',
                          size: AppDimensions.FONT_SIZE_12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),

                        Spacer(),
                        appTextView(
                          textAlign: TextAlign.end,
                          text: order.getPrice(),
                          size: AppDimensions.FONT_SIZE_14,
                          fontFamily: 'Poppins',
                          color: AppColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
