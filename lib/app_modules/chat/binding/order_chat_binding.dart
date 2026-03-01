import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/chat/controllers/order_chat_controller.dart';

class OrderChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderChatController>(() => OrderChatController());
  }
}
