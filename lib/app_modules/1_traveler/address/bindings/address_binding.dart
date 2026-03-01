// bindings/address_binding.dart
import 'package:get/get.dart';
import '../controllers/address_controller.dart';

class AddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(() => AddressController());
  }
}
