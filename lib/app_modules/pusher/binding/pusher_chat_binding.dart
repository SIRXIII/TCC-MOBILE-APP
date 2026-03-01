// bindings/chat_binding.dart
import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/pusher/controllers/pusher_chat_controller.dart';

class PusherChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PusherChaController>(() => PusherChaController());
  }
}
