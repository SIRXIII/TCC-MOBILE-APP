import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/orders_api_response.dart';
import 'package:travel_clothing_club_flutter/utils/cacheImage/app_image_view.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';

import '../../../../2_rider/profile/views/rider_profile_view.dart';

Widget ordersItemView(Items item) {
  return InkWell(
    onTap: () {
      // Get.toNamed(AppRoutes.orderTracking);
      // controller.navigateToOrderTracking(order);
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppCacheImageView(
            imageUrl: item.getImage(),
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
                appTextView(
                  text: item.getName(),
                  size: AppDimensions.FONT_SIZE_14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      appTextView(
                        text: 'Size:',
                        size: AppDimensions.FONT_SIZE_12,
                        fontFamily: 'Poppins',
                        // fontWeight: FontWeight.w600,
                      ),
                      appTextView(
                        text: ' ${item.getSize()}',
                        size: AppDimensions.FONT_SIZE_12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    // color: AppColors.PARROT,
                    width: Get.width * 0.63,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        appTextView(
                          text: 'Rental Duration:',
                          size: AppDimensions.FONT_SIZE_12,
                          fontFamily: 'Poppins',
                          // fontWeight: FontWeight.w600,
                        ),

                        appTextView(
                          text: ' ${item.getRentalDays()}',
                          size: AppDimensions.FONT_SIZE_12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),

                        Spacer(),
                        appTextView(
                          textAlign: TextAlign.end,
                          text: '\$${item.getPrice()}',
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
