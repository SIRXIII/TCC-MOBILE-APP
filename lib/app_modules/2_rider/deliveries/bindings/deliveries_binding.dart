import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/deliveries/controllers/deliveries_controller.dart';

class DeliveriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveriesController>(() => DeliveriesController());
  }
}
