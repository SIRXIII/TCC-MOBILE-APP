// To parse this JSON data, do
//
//     final supportTicketApiResponse = supportTicketApiResponseFromJson(jsonString);

import '../../../utils/app_imports.dart';

SupportTicketApiResponse supportTicketApiResponseFromJson(String str) =>
    SupportTicketApiResponse.fromJson(json.decode(str));

String supportTicketApiResponseToJson(SupportTicketApiResponse data) =>
    json.encode(data.toJson());

class SupportTicketApiResponse {
  bool? success;
  String? message;
  List<SupportTicketModel>? data;

  SupportTicketApiResponse({this.success, this.message, this.data});

  factory SupportTicketApiResponse.fromJson(Map<String, dynamic> json) =>
      SupportTicketApiResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SupportTicketModel>.from(
                json["data"]!.map((x) => SupportTicketModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SupportTicketModel {
  int? id;
  String? ticketId;
  int? orderId;
  String? subject;
  String? message;
  String? status;
  Sender? sender;
  Order? order;
  List<dynamic>? messages;
  String? createdAt;
  String? updatedAt;

  SupportTicketModel({
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

  factory SupportTicketModel.fromJson(Map<String, dynamic> json) =>
      SupportTicketModel(
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
            : List<dynamic>.from(json["messages"]!.map((x) => x)),
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
        : List<dynamic>.from(messages!.map((x) => x)),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  int getId() {
    return id ?? 0;
  }

  String getSubject() {
    return subject ?? '';
  }

  String getReason() {
    return message ?? '';
  }

  String getRequestedAt() {
    return createdAt ?? '';
  }

  String getStatus() {
    return status ?? '';
  }

  String getTicketId() {
    return ticketId ?? '';
  }

  int getOrderId() {
    return orderId ?? 0;
  }

  Color getStatusColor() {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.blue;
      case 'processing':
        return Colors.amber;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'returned':
        return Colors.deepOrange;
      case 'refunded':
        return Colors.teal;
      default:
        return Colors.grey;
    }
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
  String? phone;
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
