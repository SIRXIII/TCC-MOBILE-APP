// bindings/refund_binding.dart
import 'package:get/get.dart';
import '../controllers/refund_controller.dart';

class RefundBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RefundController>(() => RefundController());
  }
}
