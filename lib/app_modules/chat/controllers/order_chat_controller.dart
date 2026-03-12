import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

enum MessageType { text }

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String orderId;
  final String message;
  final MessageType type;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.orderId,
    required this.message,
    required this.type,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "orderId": orderId,
      "message": message,
      "type": type.name,
      "timestamp": timestamp.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map["id"],
      senderId: map["senderId"],
      receiverId: map["receiverId"],
      orderId: map["orderId"],
      message: map["message"],
      type: MessageType.values.firstWhere((e) => e.name == map["type"]),
      timestamp: DateTime.fromMillisecondsSinceEpoch(map["timestamp"]),
    );
  }
}

class OrderChatController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isSending = false.obs;
  // RxString messageText = "".obs;

  late String currentUserId; // rider or traveler
  late String receiverId; // the other user
  late String orderId; // the Order

  // --------------------------------------------
  // Load order messages
  // --------------------------------------------
  Stream<List<ChatMessage>> messagesForOrder(String orderId) {
    return _firestore
        .collection("orders_chat")
        .doc(orderId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatMessage.fromMap(doc.data()))
              .toList();
        });
  }

  // --------------------------------------------
  // Send message
  // --------------------------------------------
  Future<void> sendMessage(String orderId, String messageText) async {
    final text = messageText.trim();
    if (text.isEmpty) return;

    try {
      isSending.value = true;

      final messageId = DateTime.now().millisecondsSinceEpoch.toString();

      final message = ChatMessage(
        id: messageId,
        senderId: currentUserId,
        receiverId: receiverId,
        orderId: orderId,
        message: text,
        type: MessageType.text,
        timestamp: DateTime.now(),
      );

      // Save message
      await _firestore
          .collection("orders_chat")
          .doc(orderId)
          .collection("messages")
          .doc(messageId)
          .set(message.toMap());

      // Update order chat header
      await _firestore.collection("orders_chat").doc(orderId).set({
        "orderId": orderId,
        "lastMessage": text,
        "updatedAt": DateTime.now().millisecondsSinceEpoch,
        "riderId": currentUserId, // optional
        "travelerId": receiverId, // optional
      }, SetOptions(merge: true));

      // messageText.value = "";
    } catch (e) {
      Get.snackbar("Error", "Unable to send message");
    } finally {
      isSending.value = false;
    }
  }
}
