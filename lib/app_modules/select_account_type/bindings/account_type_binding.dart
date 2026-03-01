// bindings/account_type_binding.dart
import 'package:get/get.dart';
import '../controllers/account_type_controller.dart';

class AccountTypeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountTypeController>(() => AccountTypeController());
  }
}