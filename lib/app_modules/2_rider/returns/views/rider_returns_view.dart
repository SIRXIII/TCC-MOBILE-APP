import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/order_status.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/controllers/deliveries_controller.dart';
import 'package:travel_clothing_club_flutter/data/app_global.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/app_logger.dart';
import 'package:travel_clothing_club_flutter/utils/cacheImage/app_image_view.dart';
import 'package:travel_clothing_club_flutter/utils/constants/app_images.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/loader/app_loader.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text_field.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/svg_icon_widget.dart';

class RiderReturnsView extends StatelessWidget {
  RiderReturnsView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // final DeliveriesController controller = Get.put(DeliveriesController());
  final DeliveriesController controller = Get.find();
  final AppGlobal _appGlobal = AppGlobal.instance;

  // --> Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            const SizedBox(height: 8),
            _buildOrdersList(),

            // Orders List
          ],
        ),
      ),
      key: _scaffoldKey,
    );
  }

  Widget _buildOrdersList() {
    return Expanded(
      child: Obx(() {
        if (controller.returnOrdersList.isEmpty) {
          return _buildEmptyState('No Orders Found', '');
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: controller.returnOrdersList.length,
          itemBuilder: (context, index) {
            final order = controller.returnOrdersList[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: InkWell(
                onTap: () {
                  AppGlobal.instance.setSelectedDelivery = order;

                  AppLogger.debugPrintLogs(
                    'isReturnsOrder',
                    order.isReturnsOrder(),
                  );
                  Get.toNamed(AppRoutes.riderDeliveriesDetails);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.s,
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

                          Spacer(),
                          Expanded(
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
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          order.getPickupBy() == ''
                              ? SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgIconWidget(
                                              assetName: AppImages.icPickupBy,
                                            ),
                                            appTextView(
                                              text: 'Return Due Date:',
                                              size: AppDimensions.FONT_SIZE_12,
                                              fontFamily: 'Poppins',
                                              // fontWeight: FontWeight.w500,
                                              color: AppColors.TEXT_1,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 6.0,
                                          ),
                                          child: appTextView(
                                            // textAlign: TextAlign.end,
                                            text:
                                                order.items?[0]
                                                    .getReturnDueDate() ??
                                                '',
                                            color: AppColors.BLACK,
                                            size: AppDimensions.FONT_SIZE_14,
                                            fontFamily: 'Roboto',
                                            // fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _appGlobal
                                            .getStatusColor(order.getStaus())
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        order.getStaus(),
                                        // controller.currentStatus.value
                                        //     .replaceAll('_', ' ')
                                        //     .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _appGlobal.getStatusColor(
                                            order.getStaus(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Row(
                              children: [
                                SvgIconWidget(
                                  assetName: AppImages.icPickup,
                                  size: 20,
                                ),
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
                              text: order.traveler?.getAddress() ?? 'N/A',
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
                                SvgIconWidget(
                                  assetName: AppImages.icPickup,
                                  size: 20,
                                ),
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
                              text: order.partner?.getAddress() ?? '',
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
                      return controller.updateOrderStatusByOrderIdLoader.isTrue
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: appLoaderView(),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  order.getStaus() == OrderStatus.returned.value
                                  ? SizedBox.shrink()
                                  : appButtonView(
                                      textSize: 13,
                                      buttonHeight: 35,
                                      buttonWidth: Get.width,
                                      buttonName:
                                          order.getStaus() ==
                                              OrderStatus.returned.value
                                          ? 'Returned'
                                          : 'Mark as Returned',
                                      buttonColor: AppColors.PRIMARY_COLOR,
                                      textColor: AppColors.WHITE,
                                      fontWeight: FontWeight.w600,
                                      onTap: () {
                                        if (order.getStaus() !=
                                            OrderStatus.returned.value) {
                                          controller.updateOrderStatusByOrderId(
                                            order.id.toString(),
                                            OrderStatus.returned.name,
                                          );
                                        }
                                      },
                                    ),
                            );
                    }),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildEmptyState(String title, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 80, color: AppColors.PRIMARY_COLOR),
          const SizedBox(height: 16),

          appTextView(
            text: title,
            color: AppColors.BLACK,
            size: AppDimensions.FONT_SIZE_18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            // isStroke: false,
          ),

          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(Map<String, dynamic> order) {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Ride?'),
        content: const Text(
          'Are you sure you want to cancel this ride? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Keep Ride'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.cancelOrder(order['id']);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cancel Ride'),
          ),
        ],
      ),
    );
  }

  void _showRateDialog(Map<String, dynamic> order) {
    double rating = 5.0;

    Get.dialog(
      AlertDialog(
        title: const Text('Rate Your Ride'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('How was your experience with this ride?'),
            const SizedBox(height: 16),
            StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          rating = index + 1.0;
                        });
                      },
                    );
                  }),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Skip')),
          TextButton(
            onPressed: () {
              Get.back();
              // controller.rateOrder(order['id'], rating);
            },
            child: const Text('Submit Rating'),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Order ID', order['id']),
            _buildDetailRow('Service Type', order['type']),
            _buildDetailRow('From', order['from']),
            _buildDetailRow('To', order['to']),
            _buildDetailRow('Date & Time', order['date']),
            _buildDetailRow('Price', order['price']),
            _buildDetailRow('Driver', order['driver']),
            _buildDetailRow(
              'Vehicle',
              '${order['vehicle']} (${order['plate']})',
            ),
            _buildDetailRow('Distance', order['distance']),
            _buildDetailRow('Duration', order['duration']),
            _buildDetailRow(
              'Status',
              controller.getStatusText(order['status']),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.BLACK,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextView(
            text: 'Assigned Deliveries',
            color: AppColors.BLACK,
            size: AppDimensions.FONT_SIZE_18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            // isStroke: false,
          ),
          _buildSearchField(),
        ],
      ),

      // leading: IconButton(
      //   icon: SvgIconWidget(assetName: AppImages.icDrawer, size: 36),
      //   onPressed: () {
      //     _scaffoldKey.currentState!.openDrawer();
      //     // Scaffold.of(context).openEndDrawer(); // Open the end drawer
      //   },
      // ),
    );
  }

  Widget _buildSearchField() {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Obx(() {
            return AppTextField(
              suffixIcon: controller.searchText.value == ''
                  ? SizedBox.shrink()
                  : InkWell(
                      child: Icon(Icons.close, color: Colors.grey[600]),
                      onTap: () {
                        controller.searchText.value = '';
                        // controller.productsApiRequest();
                      },
                    ),
              isPrefix: true,
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              borderColor: Colors.grey[200]!,
              controller: TextEditingController(
                text: controller.searchText.value,
              ),
              isborderline: true,
              hintSize: AppDimensions.FONT_SIZE_16,
              hintColor: AppColors.TEXT_1,
              hint: 'Search',
              borderRadius: BorderRadius.circular(12),

              onFieldSubmitted: (value) {
                controller.searchProducts(value);
              },
              textInputAction: TextInputAction.search,
              // textInputType: TextInputType.emailAddress,
            );
          }),
          /* Row(
            children: [
              const SizedBox(width: 16),
              Icon(Icons.search, color: Colors.grey[600]),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search ',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    // Handle search
                    controller.searchProducts(value);
                  },
                ),
              ),
              // const SizedBox(width: 8),
              // Container(
              //   margin: const EdgeInsets.only(right: 8),
              //   padding: const EdgeInsets.all(6),
              //   decoration: BoxDecoration(
              //     color: AppColors.PRIMARY_COLOR,
              //     shape: BoxShape.circle,
              //   ),
              //   child: Icon(Icons.tune, color: Colors.white, size: 18),
              // ),
            ],
          ),*/
        ),
      ],
    );
  }
}
