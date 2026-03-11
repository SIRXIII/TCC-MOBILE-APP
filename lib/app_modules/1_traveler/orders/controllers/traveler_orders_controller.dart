// controllers/traveler_orders_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/order_status.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/orders_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/request_return_api_response.dart';
import 'package:travel_clothing_club_flutter/data/user_preferences.dart';
import 'package:travel_clothing_club_flutter/repositories/order_repository.dart';
import 'package:travel_clothing_club_flutter/routes/app_routes.dart';
import 'package:travel_clothing_club_flutter/utils/app_toast_view.dart';

class TravelerOrdersController extends GetxController {
  // Selected tab index
  final RxInt selectedTabIndex = 0.obs;
  final RxString selectedReturnType = 'Returned'.obs;

  // Tab titles
  // final List<String> tabTitles = ['Upcoming', 'Completed', 'Cancelled'];

  List<Order> get filteredOrders {
    switch (selectedTabIndex.value) {
      case 0: // Upcoming
        return getPendingAndActiveOrders();
        ordersList
            .where((order) => order.status == OrderStatus.pending.value)
            .toList();
      case 1: // Completed
        return ordersList
            .where(
              (order) => order.status == getSelectedOrderType(),
              /* (selectedReturnType.value == 'Refunded'
                      ? OrderStatus.refunded.value
                      : OrderStatus.cancelled.value),*/
            )
            .toList();
      case 2: // Cancelled
        return ordersList
            .where((order) => order.status == 'cancelled')
            .toList();
      default:
        return ordersList;
    }
  }

  String getSelectedOrderType() {
    switch (selectedReturnType.value) {
      case 'Returned':
        return OrderStatus.returned.value;
      case 'Refunded':
        return OrderStatus.refunded.value;
      case 'Canceled':
        return OrderStatus.cancelled.value;
      case 'Completed':
        return OrderStatus.delivered.value;
      default:
        return '';
    }
  }

  List<Order> getCompletedOrders() {
    final activeStatuses = {
      OrderStatus.delivered.value,
      OrderStatus.returned.value,
    };

    return ordersList
        .where((order) => activeStatuses.contains(order.status))
        .toList();
  }

  List<Order> getPendingAndActiveOrders() {
    final activeStatuses = {
      OrderStatus.pending.value,
      OrderStatus.approved.value,
      OrderStatus.active.value,
      OrderStatus.processing.value,
      OrderStatus.shipped.value,
    };

    return ordersList
        .where((order) => activeStatuses.contains(order.status))
        .toList();
  }

  // In your orders view, when tapping on an upcoming order:
  void navigateToOrderTracking(Map<String, dynamic> order) {
    Get.toNamed(AppRoutes.orderTracking, arguments: order);
  }

  // Get order count for each tab
  int getUpcomingCount() {
    return getPendingAndActiveOrders().length;
  }

  int getCompletedCount() {
    return getCompletedOrders().length;
    // return ordersList
    //     .where((order) => order.status == OrderStatus.cancelled.value)
    //     .length;
  }

  int getCancelledCount() {
    return ordersList.where((order) => order.status == 'cancelled').length;
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
  void rateOrder(String orderId, double rating) {
    final index = ordersList.indexWhere(
      (order) => order.id.toString() == orderId,
    );
    if (index != -1) {
      ordersList[index].rider?.rating = rating;
      ordersList.refresh();

      Get.snackbar(
        'Thank You!',
        'Rating submitted for order $orderId',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  // // Get status color
  // Color getStatusColor(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'pending':
  //       return Colors.orange;
  //     case 'approved':
  //       return Colors.blue;
  //     case 'processing':
  //       return Colors.amber;
  //     case 'shipped':
  //       return Colors.purple;
  //     case 'delivered':
  //       return Colors.green;
  //     case 'cancelled':
  //       return Colors.red;
  //     case 'returned':
  //       return Colors.deepOrange;
  //     case 'refunded':
  //       return Colors.teal;
  //     default:
  //       return Colors.grey;
  //   }
  // }

  // Get status text
  // String getStatusText(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'pending':
  //       return 'Pending';
  //     case 'approved':
  //       return 'Approved';
  //     case 'processing':
  //       return 'Processing';
  //     case 'shipped':
  //       return 'Shipped';
  //     case 'delivered':
  //       return 'Delivered';
  //     case 'cancelled':
  //       return 'Cancelled';
  //     case 'returned':
  //       return 'Returned';
  //     case 'refunded':
  //       return 'Refunded';
  //     default:
  //       return 'Unknown';
  //   }
  // }

  // Check if there are any orders
  bool get hasOrders => ordersList.isNotEmpty;

  // --> Get Orders
  var getOrdersApiRequestLoader = false.obs;
  final UserPreferences userPreferences = UserPreferences.instance;

  final _ordersList = <Order>[].obs;

  RxList<Order> get ordersList => _ordersList;

  set setOrdersList(List<Order> orders) {
    _ordersList.value = List.from(orders);
  }

  Future<void> getOrdersApiRequest() async {

    getOrdersApiRequestLoader(_ordersList.isBlank);

    Map<String, dynamic> requestBody = {};

    var response = await OrderRepository.instance.getOrders(requestBody);
    final productsApiResponse = orderApiResponseFromJson(response);

    if (response != null) {
      if (productsApiResponse.success ?? false) {
        setOrdersList = productsApiResponse.data?.orders ?? [];

        // appToastView(title: productsApiResponse.message.toString());

        getOrdersApiRequestLoader(false);
      } else {
        appToastView(title: productsApiResponse.message.toString());
      }
      getOrdersApiRequestLoader(false);
    }
    getOrdersApiRequestLoader(false);
  }

  /// Return request
  var requestReturnApiRequestLoader = false.obs;

  Future<void> requestReturnApiRequest(
    String address,
    String time,
    Order selectedOrder,
  ) async {

    requestReturnApiRequestLoader(true);

    Map<String, dynamic> requestBody = {
      "traveler_id": selectedOrder.traveler?.getId() ?? '',
      "partner_id": selectedOrder.partner?.getId() ?? '',
      "order_id": selectedOrder.id ?? '',
      "product_id": selectedOrder.items?[0].productId ?? 0,
      "address": address,
      "time": time,
    };

    var response = await OrderRepository.instance.requestReturn(requestBody);
    final apiResponse = requestReturnApiResponseFromJson(response);

    if (response != null) {
      if (apiResponse.success ?? false) {
        // setOrdersList = productsApiResponse.data?.orders ?? [];

        appToastView(title: apiResponse.message.toString());

        requestReturnApiRequestLoader(false);
        Get.back();
      } else {
        appToastView(title: apiResponse.message.toString());
      }
      requestReturnApiRequestLoader(false);
    }
    requestReturnApiRequestLoader(false);
  }
}
