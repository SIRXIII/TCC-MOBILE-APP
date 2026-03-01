// bindings/traveler_dashboard_binding.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/controllers/traveler_home_controller.dart';
import '../controllers/traveler_dashboard_controller.dart';

class TravelerDashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelerDashboardController>(
      () => TravelerDashboardController(),
    );
  }
}

class TravelerHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelerHomeController>(() => TravelerHomeController());
  }
}
