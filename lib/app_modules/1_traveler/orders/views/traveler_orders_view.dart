// views/traveler_orders_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/order_status.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/views/components/select_return_type_sheet.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/views/components/traveler_orders_item_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/controllers/deliveries_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/model/rider_deliveries_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/feedback/feedback_botttom_sheet_view.dart';
import 'package:travel_clothing_club_flutter/data/app_global.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/cacheImage/app_image_view.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/loader/app_loader.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_button.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import '../controllers/traveler_orders_controller.dart';
import 'components/return_pick_address_sheet_view.dart';

class TravelerOrdersView extends StatefulWidget {
  const TravelerOrdersView({super.key});

  @override
  State<TravelerOrdersView> createState() => _TravelerOrdersViewState();
}

class _TravelerOrdersViewState extends State<TravelerOrdersView> {
  // --> PROPERTIES
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // final TravelerOrdersController controller = Get.put(
  //   TravelerOrdersController(),
  // );

  final TravelerOrdersController controller =
      Get.find<TravelerOrdersController>();

  final DeliveriesController deliveriesController = Get.put(
    DeliveriesController(),
  );

  // --> initState
  @override
  void initState() {
    super.initState();
    debugPrint('initState --> TravelerOrdersView ');
    controller.getOrdersApiRequest();
  }

  // --> Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            // _buildSearchField(),
            // Custom Top Tabs
            _buildCustomTabs(),

            Obx(() {
              return controller.selectedTabIndex.value == 0
                  ? _buildOrdersList()
                  : _buildReturnsList();
            }),

            // Orders List
          ],
        ),
      ),
      key: _scaffoldKey,
    );
  }

  // --> _buildCustomTabs
  Widget _buildCustomTabs() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Obx(
          () => Row(
            children: [
              _buildTabItem(
                'Orders',
                0,
                controller.getOrdersApiRequestLoader.isTrue
                    ? 0
                    : controller.getUpcomingCount(),
              ),
              _buildTabItem(
                'Returns',
                1,
                controller.getOrdersApiRequestLoader.isTrue
                    ? 0
                    : controller.getCompletedCount(),
              ),
              // _buildTabItem('Cancelled', 2, controller.getCancelledCount()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index, int count) {
    return Obx(() {
      bool isSelected = controller.selectedTabIndex.value == index;

      return Expanded(
        child: InkWell(
          onTap: () => controller.changeTab(index),
          child: Container(
            // decoration: BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(
            //       color: isSelected ? Colors.green : Colors.transparent,
            //       width: 3,
            //     ),
            //   ),
            // ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.PRIMARY_COLOR.withOpacity(0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? AppColors.PRIMARY_COLOR
                    : AppColors.TRANSPARENT,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: AppColors.PRIMARY_COLOR,
                    // blurRadius: 8,
                    // offset: const Offset(0, 2),
                  )
                else
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    // blurRadius: 4,
                    // offset: const Offset(0, 1),
                  ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? AppColors.WHITE : AppColors.BLACK,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ' (${count.toString()})',
                    // count.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? AppColors.WHITE : AppColors.BLACK,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildOrdersList() {
    return Expanded(
      child: Obx(() {
        if (controller.getOrdersApiRequestLoader.isTrue) {
          return Center(child: appLoaderView());
        }
        if (controller.filteredOrders.isEmpty) {
          return _buildEmptyState('No Orders Found', '');
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: controller.filteredOrders.length,
          itemBuilder: (context, index) {
            final order = controller.filteredOrders[index];

            return travelerOrdersItemView(order);

            // return _buildOrderCard(order);
          },
        );
      }),
    );
  }

  // --> _buildReturnsList
  Widget _buildReturnsList() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  selectReturnTypeSheetView();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appTextView(
                        text: controller.selectedReturnType.value,
                        size: AppDimensions.FONT_SIZE_14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: AppColors.BLACK,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.BLACK,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.getOrdersApiRequestLoader.isTrue) {
                return Center(child: appLoaderView());
              }

              if (controller.filteredOrders.isEmpty) {
                return _buildEmptyState('No Returns Found', '');
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: controller.filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = controller.filteredOrders[index];
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
                        // controller.navigateToOrderTracking(order);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppCacheImageView(
                            imageUrl: order.items?[0].getImage() ?? '',
                            height: Get.height * 0.155,
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
                                  text: ' ${order.items?[0].getName()}',
                                  size: AppDimensions.FONT_SIZE_14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
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
                                      OrderStatus.getStatusText(
                                        order.getStatus(),
                                      ),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: OrderStatus.getStatusColor(
                                          order.getStatus(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: SizedBox(
                                    width: Get.width * 0.62,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        appTextView(
                                          text: 'Return Due:',
                                          size: AppDimensions.FONT_SIZE_12,
                                          fontFamily: 'Poppins',
                                          // fontWeight: FontWeight.w600,
                                        ),

                                        appTextView(
                                          text:
                                              ' ${order.items?[0].getReturnDueDate()}',
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

                                SizedBox(height: 8),

                                SizedBox(
                                  width: Get.width * 0.6,
                                  height: 30,
                                  child: appButtonView(
                                    textSize: 12,
                                    buttonHeight: 30,
                                    buttonName: order.showRefundButton()
                                        ? 'Request Return'
                                        : 'Add Rating',
                                    buttonColor: AppColors.PRIMARY_COLOR
                                        .withValues(alpha: 0.1),
                                    textColor: AppColors.PRIMARY_COLOR,
                                    borderColor: AppColors.PRIMARY_COLOR,
                                    buttonRadius:
                                        AppBorderRadius.BORDER_RADIUS_8,
                                    onTap: () {
                                      if (order.showRefundButton()) {
                                        returnPickAddressBottomSheet(
                                          order: order,
                                        );
                                      } else {
                                        Get.bottomSheet(
                                          FeedbackBottomSheetView(
                                            deliveries: Deliveries(
                                              id: order.id ?? 0,
                                              rider: order.rider,
                                            ),
                                          ),
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                        ).whenComplete(() {
                                          deliveriesController
                                              .resetFeedbackData();
                                          print("Bottom sheet closed!");
                                        });
                                      }
                                    },
                                  ),
                                ),
                                // order.showRefundButton()
                                //     ? GestureDetector(
                                //         onTap: () {
                                //           returnPickAddressBottomSheet(
                                //             order: order,
                                //           );
                                //         },
                                //         child: Padding(
                                //           padding: const EdgeInsets.only(
                                //             top: 4.0,
                                //           ),
                                //           child: Container(
                                //             width: Get.width * 0.6,
                                //             height: 30,
                                //             decoration: BoxDecoration(
                                //               color: AppColors.PRIMARY_COLOR
                                //                   .withOpacity(0.1),
                                //               shape: BoxShape.rectangle,
                                //               borderRadius: AppBorderRadius
                                //                   .BORDER_RADIUS_10,
                                //               border: Border.all(
                                //                 color: AppColors.PRIMARY_COLOR,
                                //                 width: 1,
                                //               ),
                                //             ),
                                //             child: Padding(
                                //               padding: const EdgeInsets.all(
                                //                 4.0,
                                //               ),
                                //               child: appTextView(
                                //                 color: AppColors.PRIMARY_COLOR,
                                //                 textAlign: TextAlign.center,
                                //                 text: 'Request Return',
                                //                 size:
                                //                     AppDimensions.FONT_SIZE_12,
                                //                 fontFamily: 'Poppins',
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     : SizedBox(
                                //         width: Get.width * 0.6,
                                //         height: 30,
                                //         child: appButtonView(
                                //           textSize: 12,
                                //           buttonHeight: 30,
                                //           buttonName: 'Add Rating',
                                //           buttonColor: AppColors.PRIMARY_COLOR
                                //               .withValues(alpha: 0.1),
                                //           textColor: AppColors.PRIMARY_COLOR,
                                //           borderColor: AppColors.PRIMARY_COLOR,
                                //           buttonRadius:
                                //               AppBorderRadius.BORDER_RADIUS_8,
                                //           onTap: () {},
                                //         ),
                                //       ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  // return _buildOrderCard(order);
                },
              );
            }),
          ),
        ],
      ),
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

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.BLACK,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appTextView(
            text: 'Orders',
            color: AppColors.BLACK,
            size: AppDimensions.FONT_SIZE_18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            // isStroke: false,
          ),
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
}
