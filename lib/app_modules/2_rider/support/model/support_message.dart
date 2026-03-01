class SupportMessage {
  String id;
  String ticketId;
  String message;
  String senderType; // 'user' or 'admin'
  String senderName;
  String? senderImage;
  DateTime timestamp;
  List<String> attachments;
  bool isRead;

  SupportMessage({
    required this.id,
    required this.ticketId,
    required this.message,
    required this.senderType,
    required this.senderName,
    this.senderImage,
    required this.timestamp,
    this.attachments = const [],
    this.isRead = false,
  });

  factory SupportMessage.fromJson(Map<String, dynamic> json) {
    return SupportMessage(
      id: json['id'],
      ticketId: json['ticketId'],
      message: json['message'],
      senderType: json['senderType'],
      senderName: json['senderName'],
      senderImage: json['senderImage'],
      timestamp: DateTime.parse(json['timestamp']),
      attachments: List<String>.from(json['attachments'] ?? []),
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'message': message,
      'senderType': senderType,
      'attachments': attachments,
    };
  }

  bool get isUserMessage => senderType == 'user';
  bool get isAdminMessage => senderType == 'admin';
}
