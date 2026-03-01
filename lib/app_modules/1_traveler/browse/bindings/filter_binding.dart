// bindings/filter_binding.dart
import 'package:get/get.dart';
import '../controllers/filter_controller.dart';

class FilterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(() => FilterController());
  }
}
