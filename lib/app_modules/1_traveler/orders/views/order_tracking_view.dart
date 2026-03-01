import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/views/components/orders_item_view.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/constants/firebase_constants.dart';
import 'package:travel_clothing_club_flutter/utils/paddings/app_border_radius.dart';
import '../controllers/order_tracking_controller.dart';

class OrderTrackingView extends StatelessWidget {
  OrderTrackingView({super.key});

  final OrderTrackingController controller = Get.put(OrderTrackingController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AppGlobal _appGlobal = AppGlobal.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomActions(),
      key: _scaffoldKey,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: appTextView(text: 'Order Tracking', fontWeight: FontWeight.w600),

      backgroundColor: AppColors.background,
      foregroundColor: AppColors.BLACK,
      elevation: 0.5,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgIconWidget(assetName: AppImages.icBack),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Tracking Progress
            _buildTrackingProgress(),
            const SizedBox(height: 16),

            // Rider Information
            if (_appGlobal.getSelectedOrder.rider != null) ...{
              _buildRiderInfoView(),
              const SizedBox(height: 16),
            },

            if (_appGlobal.getSelectedOrder.partner != null) ...{
              _buildPartnerInfoView(),
              const SizedBox(height: 16),
            },
            // Order Summary Card
            _buildOrderSummaryCard(),

            const SizedBox(height: 12),
            _orderItemView(),
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

  Widget _buildOrderSummaryCard() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTextView(
                  text: 'Order ID:',
                  size: AppDimensions.FONT_SIZE_12,
                  fontFamily: 'Roboto',
                  // fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 4),
                appTextView(
                  text: _appGlobal.getSelectedOrder.getOrderIdName(),
                  size: AppDimensions.FONT_SIZE_14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTextView(
                  text: 'Address:',
                  size: AppDimensions.FONT_SIZE_12,
                  fontFamily: 'Roboto',
                  // fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 4),
                appTextView(
                  // text: _appGlobal.getSelectedOrder.rider?.getLocation() ?? 'N/A',
                  text:
                      _appGlobal.getSelectedOrder.traveler?.getLocation() ??
                      'N/A',
                  size: AppDimensions.FONT_SIZE_14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTextView(
                  text: 'Item:',
                  size: AppDimensions.FONT_SIZE_12,
                  fontFamily: 'Roboto',
                  // fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 4),
                appTextView(
                  text:
                      _appGlobal.getSelectedOrder.items?.length.toString() ??
                      '',
                  size: AppDimensions.FONT_SIZE_14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTextView(
                  text: 'Payment:',
                  size: AppDimensions.FONT_SIZE_12,
                  fontFamily: 'Roboto',
                  // fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 4),
                appTextView(
                  text: 'Stripe',
                  size: AppDimensions.FONT_SIZE_14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTextView(
                  text: 'Return due date:',
                  size: AppDimensions.FONT_SIZE_12,
                  fontFamily: 'Roboto',
                  // fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 4),
                appTextView(
                  text:
                      _appGlobal.getSelectedOrder.items?[0]
                          .getReturnDueDate() ??
                      '',
                  size: AppDimensions.FONT_SIZE_14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            // Order Details
            /*   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOrderDetail('Order ID', controller.orderDetails['id']),
                _buildOrderDetail('Price', controller.orderDetails['price']),
                _buildOrderDetail(
                  'Distance',
                  controller.orderDetails['distance'],
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetail(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTrackingProgress() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Order Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                /*             Obx(() {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: controller
                          .getStatusColor(controller.currentStatus.value)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.currentStatus.value
                          .replaceAll('_', ' ')
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: controller.getStatusColor(
                          controller.currentStatus.value,
                        ),
                      ),
                    ),
                  );
                }),*/
              ],
            ),

            /*    const SizedBox(height: 16),

            // Progress Bar
            Obx(() {
              return LinearProgressIndicator(
                value: controller.progressValue.value,
                backgroundColor: Colors.grey[200],
                color: Colors.green,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              );
            }),
                const SizedBox(height: 8),

            // Estimated Time
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    'Estimated arrival: ${controller.estimatedArrival.value}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              );
            }),
            */
            const SizedBox(height: 16),

            // Tracking Steps
            _buildTrackingSteps(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingSteps() {
    return Column(
      children: List.generate(controller.trackingSteps.length, (index) {
        final step = controller.trackingSteps[index];
        final isCompleted = controller.isStepCompleted(index);
        final isCurrent = controller.isStepCurrent(index);

        return _buildTrackingStep(step, index, isCompleted, isCurrent);
      }),
    );
  }

  Widget _buildTrackingStep(
    Map<String, dynamic> step,
    int index,
    bool isCompleted,
    bool isCurrent,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? step['color'] as Color
                  : (isCurrent ? step['color'] as Color : Colors.grey[300]),
              shape: BoxShape.circle,
            ),
            child: isCompleted
                ? SvgIconWidget(assetName: AppImages.icChecked)
                : SvgIconWidget(assetName: AppImages.icCheck),

            /*Icon(
              step['icon'] as IconData,
              color: isCompleted || isCurrent ? Colors.white : Colors.grey[500],
              size: 20,
            ),*/
          ),

          const SizedBox(width: 12),

          // Step Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appTextView(
                  text: step['title'],
                  size: AppDimensions.FONT_SIZE_14,
                  fontFamily: 'Roboto',
                  color: AppColors.BLACK,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                ),
                // Text(
                //   step['title'],
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                //     color: isCompleted || isCurrent
                //         ? Colors.black
                //         : Colors.grey[600],
                //   ),
                // ),
                // const SizedBox(height: 2),
                /* Text(
                  step['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: isCompleted || isCurrent
                        ? Colors.grey[600]
                        : Colors.grey[400],
                  ),
                ),*/
                const SizedBox(height: 4),
                Text(
                  step['time'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          // Status Indicator
          // if (isCurrent)
          //   Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //     decoration: BoxDecoration(
          //       color: Colors.green.withOpacity(0.1),
          //       borderRadius: BorderRadius.circular(8),
          //       border: Border.all(color: Colors.green),
          //     ),
          //     child: const Text(
          //       'LIVE',
          //       style: TextStyle(
          //         fontSize: 10,
          //         color: Colors.green,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  /// _buildRiderInfoView
  Widget _buildRiderInfoView() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Rider',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    debugPrint(
                      'Chat with Rider --> ${_appGlobal.getSelectedOrder.getOrderIdName()} - ${_appGlobal.getSelectedOrder.rider?.getRiderId()}',
                    );

                    AppGlobal.instance.chatWith = 'Rider';
                    AppGlobal.instance.chatWithName =
                        _appGlobal.getSelectedOrder.rider?.getName() ?? '';
                    AppGlobal.instance.orderId = _appGlobal.getSelectedOrder
                        .getOrderIdName();

                    Get.toNamed(
                      AppRoutes.orderChat,
                      arguments: {
                        // FirebaseConstants.orderId: order
                        //     .getOrderIdName()
                        //     .toString(),
                        // "currentUserId": user.id,
                        FirebaseConstants.receiverId:
                            _appGlobal.getSelectedOrder.rider?.getRiderId() ??
                            '',
                      },
                    );

                    // Get.toNamed(
                    //   AppRoutes.travelerChat,
                    //   parameters: {
                    //     FirebaseConstants.receiverId: order
                    //         .getOrderIdName(),
                    //     FirebaseConstants.receiverName:
                    //         order.rider?.getName() ?? '',
                    //   },
                    // );
                  },
                  child: Icon(
                    Icons.chat_rounded,
                    color: AppColors.GRAY,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                AppCacheImageView(
                  imageUrl:
                      _appGlobal.getSelectedOrder.rider?.getProfilePhoto() ??
                      '',
                  height: 30, // make sure width = height for a perfect circle
                  width: 30,
                  isProfile: true,
                  boxFit: BoxFit.cover,
                ),

                const SizedBox(width: 8),

                // Driver Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          appTextView(
                            text:
                                _appGlobal.getSelectedOrder.rider?.getName() ??
                                '',
                            size: AppDimensions.FONT_SIZE_16,
                            fontFamily: 'Roboto',
                            color: AppColors.BLACK,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 12),
                          _appGlobal.getSelectedOrder.rider?.getRating() == ''
                              ? SizedBox.shrink()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: AppColors.PRIMARY_COLOR,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      _appGlobal.getSelectedOrder.rider
                                              ?.getRating() ??
                                          '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),

                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appTextView(
                    text: 'Pickup at:',
                    size: AppDimensions.FONT_SIZE_12,
                    fontFamily: 'Roboto',
                    // fontWeight: FontWeight.w600,
                  ),

                  const SizedBox(height: 4),
                  appTextView(
                    text: '20 Dec',
                    size: AppDimensions.FONT_SIZE_14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
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
        ),
      ),
    );
  }

  /// _buildPartnerInfoView
  Widget _buildPartnerInfoView() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Partner',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    debugPrint(
                      'Chat with Partner --> ${_appGlobal.getSelectedOrder.getOrderId()} - ${_appGlobal.getSelectedOrder.partner?.getId() ?? ''}',
                    );

                    debugPrint(
                      'Order Id --> ${_appGlobal.getSelectedOrder.getOrderId()}',
                    );

                    debugPrint(
                      'Ticket Id --> ${_appGlobal.getSelectedOrder.getTicketId()}',
                    );

                    _appGlobal.chatWith = 'Partner';
                    _appGlobal.ticketId = _appGlobal.getSelectedOrder
                        .getTicketId();
                    _appGlobal.orderId = _appGlobal.getSelectedOrder
                        .getOrderId();
                    _appGlobal.chatWithName =
                        _appGlobal.getSelectedOrder.partner?.getName() ?? '';

                    _appGlobal.chatWithId =
                        _appGlobal.getSelectedOrder.partner?.getId() ?? '';

                    if (_appGlobal.getSelectedOrder.getTicketId() != 0) {
                      Get.toNamed(AppRoutes.pusherChat);
                    } else {
                      controller.addSupportTicketApiRequest(
                        _appGlobal.getSelectedOrder.getId(),
                      );
                    }
                  },
                  child: Icon(
                    Icons.chat_rounded,
                    color: AppColors.GRAY,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                AppCacheImageView(
                  imageUrl:
                      _appGlobal.getSelectedOrder.partner?.getProfileImage() ??
                      '',
                  height: 30, // make sure width = height for a perfect circle
                  width: 30,
                  isProfile: true,
                  boxFit: BoxFit.cover,
                ),

                const SizedBox(width: 8),

                // Driver Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          appTextView(
                            text:
                                _appGlobal.getSelectedOrder.partner
                                    ?.getName() ??
                                '',
                            size: AppDimensions.FONT_SIZE_16,
                            fontFamily: 'Roboto',
                            color: AppColors.BLACK,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 12),
                          _appGlobal.getSelectedOrder.partner?.getRating() == ''
                              ? SizedBox.shrink()
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: AppColors.PRIMARY_COLOR,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      _appGlobal.getSelectedOrder.rider
                                              ?.getRating() ??
                                          '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),

                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: GetPlatform.isAndroid ? 4.0 : 24.0,
              ),
              child: InkWell(
                onTap: () {
                  // _appGlobal.orderId = _appGlobal.getSelectedOrder.getOrderId();
                  Get.toNamed(AppRoutes.createRefundRequest);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.PRIMARY_COLOR.withOpacity(0.1),
                    shape: BoxShape.rectangle,
                    borderRadius: AppBorderRadius.BORDER_RADIUS_10,
                    border: Border.all(
                      color: AppColors.PRIMARY_COLOR.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: appTextView(
                      textAlign: TextAlign.center,
                      text: 'Request Refund',
                      size: AppDimensions.FONT_SIZE_14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
            /*OutlinedButton(
              onPressed: controller.cancelRide,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Request Refund'),*/
          ),

          // const SizedBox(width: 12),
          // Expanded(
          //   child: ElevatedButton(
          //     onPressed: controller.contactDriver,
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.green,
          //       foregroundColor: Colors.white,
          //       padding: const EdgeInsets.symmetric(vertical: 12),
          //     ),
          //     child: const Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(Icons.phone, size: 18),
          //         SizedBox(width: 8),
          //         Text('Call Driver'),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _orderItemView() {
    final orderItems = _appGlobal.getSelectedOrder.items ?? [];
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
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (orderItems.isNotEmpty) ...[
            ...orderItems.map((orderItem) => ordersItemView(orderItem)),
            const SizedBox(height: 24),
          ],
        ],
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
              imageUrl: _appGlobal.getSelectedOrder.items?[0].getImage() ?? '',
              height: Get.height * 0.128,
              width: Get.width * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  appTextView(
                    text: _appGlobal.getSelectedOrder.items?[0].getName() ?? '',
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
                          text:
                              ' ${_appGlobal.getSelectedOrder.items?[0].getSize() ?? ''}',
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
                            text:
                                ' ${_appGlobal.getSelectedOrder.items?[0].getRentalDays()}',
                            size: AppDimensions.FONT_SIZE_12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),

                          Spacer(),
                          appTextView(
                            textAlign: TextAlign.end,
                            text:
                                '\$${_appGlobal.getSelectedOrder.items?[0].getPrice()}',
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
