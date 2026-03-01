import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/2_rider/support/controllers/support_controller.dart';

class RiderSupportBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ApiClient());
    // Get.lazyPut<SupportRepository>(
    //       () => SupportRepositoryImpl(apiClient: Get.find()),
    // );
    Get.lazyPut(() => RiderSupportController());
  }
}
