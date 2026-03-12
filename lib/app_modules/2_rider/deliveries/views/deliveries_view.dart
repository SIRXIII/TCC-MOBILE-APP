import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/controllers/deliveries_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/model/rider_deliveries_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/views/components/deliveries_item_view.dart';
import 'package:travel_clothing_club_flutter/utils/fonts/app_dimensions.dart';
import 'package:travel_clothing_club_flutter/utils/loader/app_loader.dart';
import 'package:travel_clothing_club_flutter/utils/themes/app_colors.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_text_field.dart';

class DeliveriesView extends StatefulWidget {
  const DeliveriesView({super.key});

  @override
  State<DeliveriesView> createState() => _DeliveriesViewState();
}

class _DeliveriesViewState extends State<DeliveriesView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final DeliveriesController controller = Get.find();

  /// --> initState
  @override
  void initState() {
    controller.getDeliveriesApiRequest();
    super.initState();
  }

  /// --> build
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
            const SizedBox(height: 12),
            appTextView(
              text: 'Assigned Deliveries',
              color: AppColors.BLACK,
              size: AppDimensions.FONT_SIZE_18,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              // isStroke: false,
            ),
            const SizedBox(height: 16),
            _buildSearchField(),
            // _buildSearchField(),
            // Custom Top Tabs
            _buildCustomTabs(),

            Obx(() {
              return controller.selectedTabIndex.value == 0
                  ? _buildOrdersList()
                  : _buildOrdersList();
            }),

            // Orders List
          ],
        ),
      ),
      key: _scaffoldKey,
    );
  }

  /// --> -buildCustomTabs
  Widget _buildCustomTabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
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
          child: Obx(() {
            return Row(
              children: [
                _buildTabItem('Pending', 0, controller.getUpcomingCount()),
                _buildTabItem(
                  'In-Progress',
                  1,
                  controller.getInProgressCount(),
                ),
                _buildTabItem(
                  'Completed',
                  2,
                  controller.ordersList
                      .where((order) => order.status == 'Delivered')
                      .length,
                ),
                // _buildTabItem('Cancelled', 2, controller.getCancelledCount()),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int selectedTab, count) {
    return Obx(() {
      bool isSelected = controller.selectedTabIndex.value == selectedTab;

      return Expanded(
        // Wrap with Expanded
        child: GestureDetector(
          onTap: () {
            controller.changeTab(selectedTab);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),

            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.PRIMARY_COLOR.withOpacity(1)
                  : AppColors.WHITE,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? AppColors.PRIMARY_COLOR
                    : AppColors.TRANSPARENT,
                width: isSelected ? 1 : 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  // const SizedBox(height: 4),
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

            return deliveriesItemView(order);
            /*return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: InkWell(
                onTap: () {
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
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
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
                                buttonName:
                                    controller.selectedTabIndex.value == 0
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
                                  } else if (controller
                                          .selectedTabIndex
                                          .value ==
                                      1) {
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
            );*/
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

  void _showRateDialog(Deliveries order) {
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
