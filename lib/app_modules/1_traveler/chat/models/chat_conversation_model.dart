// models/chat_conversation_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatConversation {
  final String id;
  final String orderID;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final Map<String, dynamic>? participantData;

  ChatConversation({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    this.orderID = '',
    this.unreadCount = 0,
    this.participantData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderID,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.millisecondsSinceEpoch,
      'unreadCount': unreadCount,
      'participantData': participantData,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  factory ChatConversation.fromMap(Map<String, dynamic> map) {
    return ChatConversation(
      id: map['id'],
      orderID: map['order_id'],
      participants: List<String>.from(map['participants']),
      lastMessage: map['lastMessage'],
      lastMessageTime: DateTime.fromMillisecondsSinceEpoch(
        map['lastMessageTime'],
      ),
      unreadCount: map['unreadCount'] ?? 0,
      participantData: map['participantData'],
    );
  }

  String get conversationId {
    participants.sort();
    return participants.join('_');
  }

  String getOtherParticipant(String currentUserId) {
    return participants.firstWhere(
      (id) => id != currentUserId,
      orElse: () => '',
    );
  }
}
