// // controllers/chat_controller.dart
// import 'package:get/get.dart';
// import 'package:travel_clothing_club_flutter/app_modules/support/model/chat_message_model.dart';
//
// class ChatController extends GetxController {
//   final RxList<ChatMessage> messages = <ChatMessage>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxBool isTyping = false.obs;
//   final RxString newMessage = ''.obs;
//
//   final List<String> _supportAgents = ['Sarah', 'Mike', 'Emma', 'David'];
//
//   final List<String> _supportResponses = [
//     "I understand your concern. Let me help you with that.",
//     "Thanks for reaching out! I'll look into this for you.",
//     "I apologize for the inconvenience. Let me check this.",
//     "That's a great question! Here's what I can tell you...",
//     "I can definitely help you with that. One moment please.",
//     "I see what you're saying. Let me assist you with this.",
//     "Thank you for your patience. I'm checking this now.",
//     "I understand your frustration. Let me resolve this for you.",
//     "That's a common question! Here's the information...",
//     "I'll need to check with our technical team about this.",
//   ];
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadInitialMessages();
//   }
//
//   void _loadInitialMessages() {
//     // Add initial welcome message
//     messages.addAll([
//       ChatMessage(
//         id: '1',
//         message:
//             'Hello! Welcome to RideShare Support. How can I help you today?',
//         timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//         isUser: false,
//         type: MessageType.text,
//       ),
//       ChatMessage(
//         id: '2',
//         message: "Hi, I'm having issues with my recent rental return.",
//         timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
//         isUser: true,
//         type: MessageType.text,
//       ),
//       ChatMessage(
//         id: '3',
//         message:
//             "I'm sorry to hear that. Could you please share your order ID so I can look into this for you?",
//         timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
//         isUser: false,
//         type: MessageType.text,
//       ),
//     ]);
//   }
//
//   void sendMessage(String message) {
//     if (message.trim().isEmpty) return;
//
//     // Add user message
//     final userMessage = ChatMessage(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       message: message.trim(),
//       timestamp: DateTime.now(),
//       isUser: true,
//     );
//
//     messages.add(userMessage);
//     newMessage.value = '';
//
//     // Simulate typing
//     _simulateTyping();
//   }
//
//   void _simulateTyping() {
//     isTyping.value = true;
//
//     // Random delay for more realistic response
//     final delay = Duration(seconds: 1 + (DateTime.now().millisecond % 3));
//
//     Future.delayed(delay, () {
//       isTyping.value = false;
//       _generateResponse();
//     });
//   }
//
//   void _generateResponse() {
//     final random = DateTime.now().millisecond;
//     final agent = _supportAgents[random % _supportAgents.length];
//     final response = _supportResponses[random % _supportResponses.length];
//
//     final supportMessage = ChatMessage(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       message: '$response\n\n- $agent, RideShare Support',
//       timestamp: DateTime.now(),
//       isUser: false,
//     );
//
//     messages.add(supportMessage);
//   }
//
//   void sendImage(String imagePath) {
//     final imageMessage = ChatMessage(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       message: 'Shared an image',
//       timestamp: DateTime.now(),
//       isUser: true,
//       type: MessageType.image,
//       imageUrl: imagePath,
//     );
//
//     messages.add(imageMessage);
//     _simulateTyping();
//   }
//
//   void clearChat() {
//     messages.clear();
//     _loadInitialMessages();
//     Get.snackbar(
//       'Chat Cleared',
//       'Chat history has been cleared',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
//
//   void markAllAsRead() {
//     for (int i = 0; i < messages.length; i++) {
//       if (!messages[i].isRead) {
//         // In a real app, you'd update the message object
//         // For now, we'll just simulate it
//       }
//     }
//   }
// }
