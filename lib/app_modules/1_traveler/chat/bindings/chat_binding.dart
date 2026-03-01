// bindings/chat_binding.dart
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class TravelerChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
