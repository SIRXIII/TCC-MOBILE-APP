import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/controllers/order_tracking_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/order_status.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/views/components/orders_item_view.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/controllers/deliveries_controller.dart';
import 'package:travel_clothing_club_flutter/app_modules/feedback/feedback_botttom_sheet_view.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/constants/firebase_constants.dart';
import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';

class DeliveriesDetailsView extends StatelessWidget {
  DeliveriesDetailsView({super.key});

  final OrderTrackingController controller = Get.put(OrderTrackingController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AppGlobal _appGlobal = AppGlobal.instance;

  final DeliveriesController deliveriesController = Get.find();

  // --> build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: appBarView(title: 'Details'),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomActions(),
      key: _scaffoldKey,
    );
  }

  /// -- Body
  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.WHITE,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildDriverInfo(),
                    const SizedBox(height: 6),
                    Divider(),
                    // Divider(),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        appTextView(
                          text: 'Order ID:',
                          size: AppDimensions.FONT_SIZE_12,
                          fontFamily: 'Poppins',
                          // fontWeight: FontWeight.w500,
                          color: AppColors.TEXT_1,
                        ),
                        Obx(() {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _appGlobal
                                  .getStatusColor(
                                    _appGlobal.getSelectedDelivery.getStaus(),
                                  )
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _appGlobal.getSelectedDelivery.getStaus(),
                              // controller.currentStatus.value
                              //     .replaceAll('_', ' ')
                              //     .toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _appGlobal.getStatusColor(
                                  _appGlobal.getSelectedDelivery.getStaus(),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 4),
                    appTextView(
                      textAlign: TextAlign.end,
                      text: _appGlobal.getSelectedDelivery.getOrderId(),
                      color: AppColors.BLACK,
                      size: AppDimensions.FONT_SIZE_14,
                      fontFamily: 'Roboto',
                      // fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 12),
                    appTextView(
                      text: 'Item:',
                      size: AppDimensions.FONT_SIZE_12,
                      fontFamily: 'Poppins',
                      // fontWeight: FontWeight.w500,
                      color: AppColors.TEXT_1,
                    ),
                    const SizedBox(height: 4),
                    appTextView(
                      textAlign: TextAlign.end,
                      text:
                          _appGlobal.getSelectedDelivery.items?[0].getName() ??
                          '',
                      color: AppColors.BLACK,
                      size: AppDimensions.FONT_SIZE_14,
                      fontFamily: 'Roboto',
                      // fontWeight: FontWeight.w600,
                    ),

                    _appGlobal.getSelectedDelivery.getPickupBy() == ''
                        ? SizedBox.shrink()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgIconWidget(
                                    assetName: AppImages.icPickupBy,
                                  ),
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
                                padding: const EdgeInsets.only(left: 0.0),
                                child: appTextView(
                                  // textAlign: TextAlign.end,
                                  text: _appGlobal.getSelectedDelivery
                                      .getPickupBy(),
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
                      padding: const EdgeInsets.only(left: 0.0),
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
                      padding: const EdgeInsets.only(left: 0.0),
                      child: appTextView(
                        text: _appGlobal.getSelectedDelivery.getPickupAddress(),
                        // text:
                        //     _appGlobal.getSelectedDelivery.partner
                        //         ?.getAddress() ??
                        //     '',
                        color: AppColors.BLACK,
                        size: AppDimensions.FONT_SIZE_14,
                        fontFamily: 'Roboto',
                        // fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
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
                      padding: const EdgeInsets.only(left: 0.0),
                      child: appTextView(
                        text: _appGlobal.getSelectedDelivery
                            .getDropOffAddress(),
                        // text:
                        //     _appGlobal.getSelectedDelivery.traveler
                        //         ?.getAddress() ??
                        //     '',
                        color: AppColors.BLACK,
                        size: AppDimensions.FONT_SIZE_14,
                        fontFamily: 'Roboto',
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    appTextView(
                      text: 'Return due date: ',
                      size: AppDimensions.FONT_SIZE_12,
                      fontFamily: 'Poppins',
                      // fontWeight: FontWeight.w500,
                      color: AppColors.TEXT_1,
                    ),
                    const SizedBox(height: 4),
                    appTextView(
                      // textAlign: TextAlign.end,
                      text:
                          _appGlobal.getSelectedDelivery.items?[0]
                              .getReturnDueDate() ??
                          '',
                      color: AppColors.BLACK,
                      size: AppDimensions.FONT_SIZE_14,
                      fontFamily: 'Roboto',
                      // fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _orderItemView(),
            const SizedBox(height: 16),
            // Tracking Progress
            // _buildTrackingProgress(),
            // const SizedBox(height: 16),

            // const SizedBox(height: 16),
            // Order Summary Card
            // _buildOrderSummaryCard(),
            // const SizedBox(height: 16),

            /*

            // Ride Details
            _buildRideDetails(),

            // Safety Features
            _buildSafetyFeatures(),*/
          ],
        ),
      ),
    );
  }

  // --> Driver Info
  Widget _buildDriverInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            // Driver Avatar
            AppCacheImageView(
              imageUrl:
                  _appGlobal.getSelectedDelivery.traveler?.getProfilePhoto() ??
                  '',
              height: 30, // make sure width = height for a perfect circle
              width: 30,
              isProfile: true,
              boxFit: BoxFit.cover,
            ),

            const SizedBox(width: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTextView(
                  text:
                      _appGlobal.getSelectedDelivery.traveler?.getName() ?? '',
                  size: AppDimensions.FONT_SIZE_16,
                  fontFamily: 'Roboto',
                  color: AppColors.BLACK,
                  fontWeight: FontWeight.bold,
                ),
                appTextView(
                  text: 'Customer',
                  size: AppDimensions.FONT_SIZE_12,
                  fontFamily: 'Roboto',
                  color: AppColors.TEXT_1,
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {

                AppGlobal.instance.chatWith = 'Traveler';
                AppGlobal.instance.orderId = _appGlobal.getSelectedDelivery
                    .getOrderId();
                AppGlobal.instance.chatWithName =
                    _appGlobal.getSelectedDelivery.traveler?.getName() ?? '';

                Get.toNamed(
                  AppRoutes.orderChat,
                  arguments: {
                    // FirebaseConstants.orderId: _appGlobal.getSelectedDelivery
                    //     .getOrderId(),
                    // "currentUserId": user.id,
                    FirebaseConstants.receiverId:
                        _appGlobal.getSelectedDelivery.traveler?.getId() ?? '',
                  },
                );
              },

              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.chat_rounded,
                  color: AppColors.GRAY,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // Driver Avatar
            AppCacheImageView(
              imageUrl:
                  _appGlobal.getSelectedDelivery.partner?.getProfileImage() ??
                  '',
              height: 30, // make sure width = height for a perfect circle
              width: 30,
              isProfile: true,
              boxFit: BoxFit.cover,
              // fit: BoxFit.cover,
            ),

            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTextView(
                  text: _appGlobal.getSelectedDelivery.partner?.getName() ?? '',
                  size: AppDimensions.FONT_SIZE_16,
                  fontFamily: 'Roboto',
                  color: AppColors.BLACK,
                  fontWeight: FontWeight.bold,
                ),
                appTextView(
                  text: 'Partner',
                  size: AppDimensions.FONT_SIZE_12,
                  fontFamily: 'Roboto',
                  color: AppColors.TEXT_1,
                ),
              ],
            ),
            Spacer(),
            // Spacer(),
            InkWell(
              onTap: () {

                _appGlobal.chatWith = 'Partner';
                _appGlobal.ticketId = _appGlobal.getSelectedDelivery
                    .getTicketId();
                _appGlobal.orderId = _appGlobal.getSelectedDelivery
                    .getOrderId();
                _appGlobal.chatWithName =
                    _appGlobal.getSelectedDelivery.partner?.getName() ?? '';
                _appGlobal.chatWithId =
                    _appGlobal.getSelectedDelivery.partner?.getId() ?? '';

                Get.toNamed(AppRoutes.pusherChat);

                /*     Get.toNamed(
                  AppRoutes.travelerChat,
                  parameters: {
                    FirebaseConstants.receiverId:
                        _appGlobal.getSelectedDelivery.partner?.getId() ?? '',
                    FirebaseConstants.receiverName:
                        _appGlobal.getSelectedDelivery.partner?.getName() ?? '',
                  },
                );*/
              },

              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.chat_rounded,
                  color: AppColors.GRAY,
                  size: 20,
                ),
              ),
            ),
            // _appGlobal.getSelectedDelivery.partner?.getRating() == ''
            //     ? SizedBox.shrink()
            //     : Row(
            //         children: [
            //           Icon(
            //             Icons.star,
            //             size: 16,
            //             color: AppColors.PRIMARY_COLOR,
            //           ),
            //           const SizedBox(width: 2),
            //           Text(
            //             _appGlobal.getSelectedDelivery.partner?.getRating() ??
            //                 '',
            //             style: const TextStyle(fontWeight: FontWeight.w600),
            //           ),
            //         ],
            //       ),

            // Driver Details
          ],
        ),
        // Driver ETA
        /* Obx(() {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Driver is on the way',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${controller.distanceToPickup.value} away • ${controller.estimatedArrival.value}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),*/
      ],
    );
  }

  Widget _buildSafetyFeatures() {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Safety Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSafetyFeature(
                  Icons.shield,
                  'Safe Ride',
                  'Verified driver',
                ),
                _buildSafetyFeature(Icons.emergency, 'Emergency', 'Quick help'),
                _buildSafetyFeature(
                  Icons.share_location,
                  'Share Trip',
                  'Real-time sharing',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyFeature(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.green),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        Text(subtitle, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.WHITE,

        // borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: GetPlatform.isAndroid ? 8.0 : 28.0, //28.0,
          left: 16,
          right: 16,
          top: 8,
        ),
        child: _appGlobal.getSelectedDelivery.isReturnsOrder()
            ? SizedBox.shrink()
            : Obx(() {
                return deliveriesController.selectedTabIndex.value == 2
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
                              FeedbackBottomSheetView(
                                deliveries: _appGlobal.getSelectedDelivery,
                              ),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                        ),
                      )
                    : deliveriesController
                          .updateOrderStatusByOrderIdLoader
                          .isTrue
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
                              deliveriesController.selectedTabIndex.value == 0
                              ? 'Mark as Picked Up'
                              : 'Mark as Delivered',
                          buttonColor: AppColors.PRIMARY_COLOR,
                          textColor: AppColors.WHITE,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            // update status Shipped

                            String status = '';
                            if (deliveriesController.selectedTabIndex.value ==
                                0) {
                              status = OrderStatus.shipped.name;
                            } else if (deliveriesController
                                    .selectedTabIndex
                                    .value ==
                                1) {
                              status = OrderStatus.delivered.name;
                            }

                            if (deliveriesController.selectedTabIndex.value ==
                                2) {}
                            deliveriesController.updateOrderStatusByOrderId(
                              _appGlobal.getSelectedDelivery.id.toString(),
                              status,
                            );
                          },
                        ),
                      );
              }),
      ),
    );
  }

  Widget _orderItemView() {
    final orderItems = _appGlobal.getSelectedDelivery.items ?? [];
    return SizedBox(
      height: Get.height * orderItems.length / 5,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        // padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: orderItems.length,
        itemBuilder: (context, index) {
          // final order = controller.filteredOrders[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ordersItemView(orderItems[index]),
          );
          // return _buildOrderCard(order);
        },
      ),
    );

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
              imageUrl:
                  _appGlobal.getSelectedDelivery.items?[0].getImage() ?? '',
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
                    text:
                        _appGlobal.getSelectedDelivery.items?[0].getName() ??
                        '',
                    size: AppDimensions.FONT_SIZE_14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        appTextView(
                          text: 'Size: ',
                          size: AppDimensions.FONT_SIZE_12,
                          fontFamily: 'Poppins',
                          // fontWeight: FontWeight.w600,
                        ),
                        appTextView(
                          text:
                              _appGlobal.getSelectedDelivery.items?[0]
                                  .getSize() ??
                              '',
                          size: AppDimensions.FONT_SIZE_12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: Get.width * 0.63,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          appTextView(
                            text: 'Rental Duration: ',
                            size: AppDimensions.FONT_SIZE_12,
                            fontFamily: 'Poppins',
                            // fontWeight: FontWeight.w600,
                          ),

                          appTextView(
                            text:
                                _appGlobal.getSelectedDelivery.items?[0]
                                    .getRentalDays() ??
                                '',
                            size: AppDimensions.FONT_SIZE_12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),

                          Spacer(),
                          appTextView(
                            textAlign: TextAlign.end,
                            text:
                                _appGlobal.getSelectedDelivery.items?[0]
                                    .getProductPriceWithCurrency() ??
                                '',
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
}
