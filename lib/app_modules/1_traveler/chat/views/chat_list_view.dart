// // views/chat_list_view.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_clothing_club_flutter/app_modules/1_traveler/chat/views/chat_conversation_view.dart';
// import 'package:travel_clothing_club_flutter/utils/widgets/app_bar_view.dart';
// import '../controllers/chat_controller.dart';
// import '../models/chat_conversation_model.dart';
//
// class ChatListView extends StatelessWidget {
//   ChatListView({super.key});
//
//   final ChatController chatController = Get.find<ChatController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarView(title: 'Chat'),
//       body: Obx(() {
//         if (chatController.isLoading.value &&
//             chatController.conversations.isEmpty) {
//           return _buildLoadingState();
//         }
//
//         if (chatController.conversations.isEmpty) {
//           return _buildEmptyState();
//         }
//
//         return _buildConversationsList();
//       }),
//     );
//   }
//
//   Widget _buildLoadingState() {
//     return const Center(child: CircularProgressIndicator());
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.chat_bubble_outline,
//             size: 80,
//             color: Colors.grey.shade400,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'No Messages',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Start a conversation with someone',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildConversationsList() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: chatController.conversations.length,
//       itemBuilder: (context, index) {
//         final conversation = chatController.conversations[index];
//         return _buildConversationCard(conversation);
//       },
//     );
//   }
//
//   Widget _buildConversationCard(ChatConversation conversation) {
//     final otherParticipantId = conversation.getOtherParticipant(
//       chatController.currentUser?.getId() ?? '',
//     );
//     final participantData = conversation.participantData?[otherParticipantId];
//     final participantName = participantData?['name'] ?? 'Unknown User';
//     final participantPhoto = participantData?['photoUrl'];
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundImage: participantPhoto != null
//               ? NetworkImage(participantPhoto)
//               : null,
//           child: participantPhoto == null
//               ? Text(participantName[0].toUpperCase())
//               : null,
//         ),
//         title: Text(
//           participantName,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text(
//           conversation.lastMessage,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               conversation.lastMessageTime.toString(),
//               style: const TextStyle(fontSize: 12, color: Colors.grey),
//             ),
//             if (conversation.unreadCount > 0) ...[
//               const SizedBox(height: 4),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   conversation.unreadCount.toString(),
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//         onTap: () {
//           Get.to(() => ChatConversationView(receiverId: otherParticipantId));
//         },
//       ),
//     );
//   }
// }
