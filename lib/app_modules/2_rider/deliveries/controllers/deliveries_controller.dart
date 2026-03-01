// controllers/traveler_orders_controller.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/order_status.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/model/rider_deliveries_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/model/update_order_status_api_response.dart';
import 'package:travel_clothing_club_flutter/repositories/feedback_repository.dart';
import 'package:travel_clothing_club_flutter/repositories/rider_deliveries_repository.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';

class DeliveriesController extends GetxController {
  /// Properties
  final RxInt selectedTabIndex = 0.obs;
  final RxString selectedReturnType = 'Upcoming'.obs;

  final RxList<File> selectedImages = <File>[].obs;
  final ImagePicker _imagePicker = ImagePicker();

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> pickImages() async {
    final List<XFile> files = await _imagePicker.pickMultiImage(
      imageQuality: 85,
    );

    for (var file in files) {
      selectedImages.add(File(file.path));
    }
  }

  /// onInit
  @override
  void onInit() {
    getDeliveriesApiRequest();
    super.onInit();
  }

  RxInt selectedRating = 0.obs;

  void selectRating(int rating) {
    selectedRating.value = rating;
  }

  var feedBackReviewController = TextEditingController().obs;

  final RxString searchText = ''.obs;
  void searchProducts(String query) {
    debugPrint('setDestination --> $query');
    searchText.value = query;
    // productsApiRequest();
  }

  // Get filtered orders based on selected tab
  List<Deliveries> get filteredOrders {
    switch (selectedTabIndex.value) {
      case 0:
        return ordersList
            .where((order) => order.status == 'Processing')
            .toList()
            .reversed
            .toList();
      case 1:
        return ordersList
            .where((order) => order.status == 'Shipped')
            .toList()
            .reversed
            .toList();
      case 2:
        return ordersList
            .where((order) => order.status == 'Delivered')
            .toList()
            .reversed
            .toList();
      default:
        return ordersList;
    }
  }

  // List<Deliveries> get returnOrdersList {
  //   return ordersList.where((order) => order.status == 'Returned').toList();
  // }
  List<Deliveries> get returnOrdersList {
    const returnStatuses = ['Return_requested', 'Returned'];

    return ordersList
        .where((order) => returnStatuses.contains(order.status))
        .toList();
  }

  String getSelectedOrderType() {
    switch (selectedReturnType.value) {
      case 'Processing':
        return OrderStatus.processing.value;
      case 'Pending':
        return OrderStatus.pending.value;
      default:
        return '';
    }
  }

  // In your orders view, when tapping on an upcoming order:
  void navigateToOrderTracking(Map<String, dynamic> order) {
    Get.toNamed(AppRoutes.orderTracking, arguments: order);
  }

  // Get order count for each tab
  int getUpcomingCount() {
    // debugPrint('getInProgressCount --> ${filteredOrders.length}');
    return ordersList.where((order) => order.status == 'Processing').length;
  }

  int getInProgressCount() {
    // debugPrint('getInProgressCount --> ${filteredOrders.length}');
    return ordersList.where((order) => order.status == 'Shipped').length;
  }

  int getCompletedCount() {
    debugPrint('getCompletedCount --> ${filteredOrders.length}');
    return ordersList.where((order) => order.status == 'Delivered').length;
  }

  // Change tab
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  // Cancel upcoming order
  void cancelOrder(String orderId) {
    final index = ordersList.indexWhere(
      (order) => order.id.toString() == orderId,
    );
    if (index != -1 && ordersList[index].status == 'upcoming') {
      ordersList[index].status = 'cancelled';
      ordersList.refresh();

      Get.snackbar(
        'Order Cancelled',
        'Order $orderId has been cancelled',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  // Rate completed order
  // void rateOrder(String orderId, double rating) {
  //   final index = ordersList.indexWhere((order) => order.id.toString() == orderId);
  //   if (index != -1) {
  //     ordersList[index]['userRating'] = rating;
  //     ordersList.refresh();
  //
  //     Get.snackbar(
  //       'Thank You!',
  //       'Rating submitted for order $orderId',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  // Get status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'upcoming':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Get status text
  String getStatusText(String status) {
    switch (status) {
      case 'upcoming':
        return 'Upcoming';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  // Check if there are any orders
  bool get hasOrders => ordersList.isNotEmpty;

  // --> Deliveries API
  final _ordersList = <Deliveries>[].obs;

  RxList<Deliveries> get ordersList => _ordersList;

  set setOrdersList(List<Deliveries> orders) {
    _ordersList.value = List.from(orders);
  }

  var getOrdersApiRequestLoader = false.obs;
  Future<void> getDeliveriesApiRequest() async {
    debugPrint('getDeliveriesApiRequest --> ');

    getOrdersApiRequestLoader(_ordersList.isBlank);

    Map<String, dynamic> requestBody = {};

    var response = await RiderDeliveriesRepository.instance.getDeliveries(
      requestBody,
    );
    final apiResponse = riderDeliveriesApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.status ?? false) {
        setOrdersList = apiResponse.data ?? [];

        // appToastView(title: productsApiResponse.message.toString());

        getOrdersApiRequestLoader(false);
      } else {
        appToastView(title: response.toString());
      }
      getOrdersApiRequestLoader(false);
    }
    getOrdersApiRequestLoader(false);
  }

  /// --> updateOrderStatusByOrderId
  var updateOrderStatusByOrderIdLoader = false.obs;
  Future<void> updateOrderStatusByOrderId(String orderId, String status) async {
    debugPrint('updateOrderStatusByOrderId --> ');

    updateOrderStatusByOrderIdLoader(true);

    Map<String, dynamic> requestBody = {"order_id": orderId, "status": status};

    var response = await RiderDeliveriesRepository.instance
        .updateDeliveryStatusByOrderId(requestBody);
    final apiResponse = updateOrderApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.status ?? false) {
        // setOrdersList = apiResponse.data ?? [];

        // appToastView(title: productsApiResponse.message.toString());

        getDeliveriesApiRequest();

        updateOrderStatusByOrderIdLoader(false);
      } else {
        appToastView(title: response.toString());
      }
      updateOrderStatusByOrderIdLoader(false);
    }
    updateOrderStatusByOrderIdLoader(false);
  }

  var addFeedbackReviewApiRequestLoader = false.obs;
  Future<void> addFeedbackReviewApiRequest(
    String orderId,
    String riderId,
    String travelerId,
  ) async {
    debugPrint('updateOrderStatusByOrderId --> ');

    if (selectedRating.value == 0) {
      appToastView(title: 'Rating is required!');
      return;
    }

    if (feedBackReviewController.value.text.isEmpty) {
      appToastView(title: 'Feedback is required!');
      return;
    }
    addFeedbackReviewApiRequestLoader(true);
    Map<String, dynamic> requestBody = {
      "rating": selectedRating.value,
      "comment": feedBackReviewController.value.text.toString(),
      "rider_id": riderId,
      "traveler_id": travelerId,
    };
    //
    // if (riderId == '') {
    //   requestBody = {"rider_id": riderId};
    // } else {
    //   requestBody = {"traveler_id": travelerId};
    // }

    var response = await FeedbackRepository.instance.rateOrder(
      requestBody,
      orderId,
    );

    var travelerToRiderRatingApiResponse = await FeedbackRepository.instance
        .travelerToRiderRating(requestBody);

    final apiResponse = updateOrderApiResponseFromJson(response);

    if (response != null) {
      appToastView(title: apiResponse.message ?? '');
      if (apiResponse.status ?? false) {
        resetFeedbackData();
        Get.back();
      }
      addFeedbackReviewApiRequestLoader(false);
    }
    addFeedbackReviewApiRequestLoader(false);
  }

  void resetFeedbackData() {
    selectRating(0);
    feedBackReviewController.value.clear();
    selectedImages.clear();
  }
}
