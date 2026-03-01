// bindings/notifications_binding.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/controllers/traveler_orders_controller.dart';

class TravelerOrdersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelerOrdersController>(() => TravelerOrdersController());
  }
}
