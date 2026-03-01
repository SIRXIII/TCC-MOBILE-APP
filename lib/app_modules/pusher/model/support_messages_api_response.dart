// To parse this JSON data, do
//
//     final supportMessagesApiResponse = supportMessagesApiResponseFromJson(jsonString);

import 'dart:convert';

SupportMessagesApiResponse supportMessagesApiResponseFromJson(String str) =>
    SupportMessagesApiResponse.fromJson(json.decode(str));

String supportMessagesApiResponseToJson(SupportMessagesApiResponse data) =>
    json.encode(data.toJson());

class SupportMessagesApiResponse {
  bool? success;
  String? message;
  Data? data;

  SupportMessagesApiResponse({this.success, this.message, this.data});

  factory SupportMessagesApiResponse.fromJson(Map<String, dynamic> json) =>
      SupportMessagesApiResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? ticketId;
  int? orderId;
  String? subject;
  String? message;
  String? status;
  Sender? sender;
  Order? order;
  List<Message>? messages;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.ticketId,
    this.orderId,
    this.subject,
    this.message,
    this.status,
    this.sender,
    this.order,
    this.messages,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    ticketId: json["ticket_id"],
    orderId: json["order_id"],
    subject: json["subject"],
    message: json["message"],
    status: json["status"],
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    messages: json["messages"] == null
        ? []
        : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_id": ticketId,
    "order_id": orderId,
    "subject": subject,
    "message": message,
    "status": status,
    "sender": sender?.toJson(),
    "order": order?.toJson(),
    "messages": messages == null
        ? []
        : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Message {
  int? id;
  String? message;
  dynamic attachment;
  String? senderType;
  int? senderId;
  String? senderName;
  dynamic senderProfile;
  DateTime? createdAt;
  DateTime? updatedAt;

  Message({
    this.id,
    this.message,
    this.attachment,
    this.senderType,
    this.senderId,
    this.senderName,
    this.senderProfile,
    this.createdAt,
    this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    message: json["message"],
    attachment: json["attachment"],
    senderType: json["sender_type"],
    senderId: json["sender_id"],
    senderName: json["sender_name"],
    senderProfile: json["sender_profile"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "attachment": attachment,
    "sender_type": senderType,
    "sender_id": senderId,
    "sender_name": senderName,
    "sender_profile": senderProfile,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  String getMessage() {
    return message ?? '';
  }

  String get timeString {
    final now = DateTime.now();
    final difference = now.difference(createdAt!);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}';
  }

  String get formattedTime {
    return '${createdAt!.hour.toString().padLeft(2, '0')}:${createdAt!.minute.toString().padLeft(2, '0')}';
  }
}

class Order {
  int? id;
  String? status;

  Order({this.id, this.status});

  factory Order.fromJson(Map<String, dynamic> json) =>
      Order(id: json["id"], status: json["status"]);

  Map<String, dynamic> toJson() => {"id": id, "status": status};
}

class Sender {
  String? type;
  int? id;
  String? name;
  String? email;
  dynamic phone;
  dynamic profilePhoto;

  Sender({
    this.type,
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePhoto,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    type: json["type"],
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    profilePhoto: json["profile_photo"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "profile_photo": profilePhoto,
  };
}
