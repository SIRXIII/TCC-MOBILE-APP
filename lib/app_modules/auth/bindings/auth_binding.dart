// bindings/account_type_binding.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/controller/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
