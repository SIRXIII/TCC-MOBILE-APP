// models/chat_message_model.dart
class ChatMessage {
  final String id;
  final String message;
  final DateTime timestamp;
  final bool isUser;
  final MessageType type;
  final String? imageUrl;
  final bool isRead;

  ChatMessage({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.isUser,
    this.type = MessageType.text,
    this.imageUrl,
    this.isRead = true,
  });

  String get timeString {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  String get formattedTime {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}

enum MessageType { text, image, system }
