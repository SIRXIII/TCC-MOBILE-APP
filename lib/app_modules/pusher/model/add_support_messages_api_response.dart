// To parse this JSON data, do
//
//     final addSupportMessagesApiResponse = addSupportMessagesApiResponseFromJson(jsonString);

import 'dart:convert';

AddSupportMessagesApiResponse addSupportMessagesApiResponseFromJson(
  String str,
) => AddSupportMessagesApiResponse.fromJson(json.decode(str));

String addSupportMessagesApiResponseToJson(
  AddSupportMessagesApiResponse data,
) => json.encode(data.toJson());

class AddSupportMessagesApiResponse {
  bool? success;
  String? message;
  Data? data;

  AddSupportMessagesApiResponse({this.success, this.message, this.data});

  factory AddSupportMessagesApiResponse.fromJson(Map<String, dynamic> json) =>
      AddSupportMessagesApiResponse(
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
  int? supportTicketId;
  int? senderableId;
  String? senderableType;
  String? message;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  Ticket? ticket;
  Senderable? senderable;

  Data({
    this.supportTicketId,
    this.senderableId,
    this.senderableType,
    this.message,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.ticket,
    this.senderable,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    supportTicketId: json["support_ticket_id"],
    senderableId: json["senderable_id"],
    senderableType: json["senderable_type"],
    message: json["message"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    id: json["id"],
    ticket: json["ticket"] == null ? null : Ticket.fromJson(json["ticket"]),
    senderable: json["senderable"] == null
        ? null
        : Senderable.fromJson(json["senderable"]),
  );

  Map<String, dynamic> toJson() => {
    "support_ticket_id": supportTicketId,
    "senderable_id": senderableId,
    "senderable_type": senderableType,
    "message": message,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "ticket": ticket?.toJson(),
    "senderable": senderable?.toJson(),
  };
}

class Senderable {
  int? id;
  dynamic profilePhoto;
  String? name;
  String? gender;
  String? size;
  dynamic dateOfBirth;
  dynamic username;
  String? email;
  DateTime? emailVerifiedAt;
  dynamic provider;
  dynamic providerId;
  dynamic avatar;
  dynamic phone;
  String? country;
  String? city;
  String? postalCode;
  String? address;
  dynamic spentAmount;
  String? status;
  String? fcmToken;
  DateTime? lastActive;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Senderable({
    this.id,
    this.profilePhoto,
    this.name,
    this.gender,
    this.size,
    this.dateOfBirth,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.provider,
    this.providerId,
    this.avatar,
    this.phone,
    this.country,
    this.city,
    this.postalCode,
    this.address,
    this.spentAmount,
    this.status,
    this.fcmToken,
    this.lastActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Senderable.fromJson(Map<String, dynamic> json) => Senderable(
    id: json["id"],
    profilePhoto: json["profile_photo"],
    name: json["name"],
    gender: json["gender"],
    size: json["size"],
    dateOfBirth: json["date_of_birth"],
    username: json["username"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
    provider: json["provider"],
    providerId: json["provider_id"],
    avatar: json["avatar"],
    phone: json["phone"],
    country: json["country"],
    city: json["city"],
    postalCode: json["postal_code"],
    address: json["address"],
    spentAmount: json["spent_amount"],
    status: json["status"],
    fcmToken: json["fcm_token"],
    lastActive: json["last_active"] == null
        ? null
        : DateTime.parse(json["last_active"]),
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_photo": profilePhoto,
    "name": name,
    "gender": gender,
    "size": size,
    "date_of_birth": dateOfBirth,
    "username": username,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "provider": provider,
    "provider_id": providerId,
    "avatar": avatar,
    "phone": phone,
    "country": country,
    "city": city,
    "postal_code": postalCode,
    "address": address,
    "spent_amount": spentAmount,
    "status": status,
    "fcm_token": fcmToken,
    "last_active": lastActive?.toIso8601String(),
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Ticket {
  int? id;
  String? ticketId;
  int? orderId;
  String? userType;
  int? userId;
  String? status;
  String? subject;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ticket({
    this.id,
    this.ticketId,
    this.orderId,
    this.userType,
    this.userId,
    this.status,
    this.subject,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    ticketId: json["ticket_id"],
    orderId: json["order_id"],
    userType: json["user_type"],
    userId: json["user_id"],
    status: json["status"],
    subject: json["subject"],
    message: json["message"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_id": ticketId,
    "order_id": orderId,
    "user_type": userType,
    "user_id": userId,
    "status": status,
    "subject": subject,
    "message": message,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
