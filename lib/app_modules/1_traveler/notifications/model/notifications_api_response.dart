// To parse this JSON data, do
//
//     final notificationsApiResponse = notificationsApiResponseFromJson(jsonString);

import 'dart:convert';

NotificationsApiResponse notificationsApiResponseFromJson(String str) =>
    NotificationsApiResponse.fromJson(json.decode(str));

String notificationsApiResponseToJson(NotificationsApiResponse data) =>
    json.encode(data.toJson());

class NotificationsApiResponse {
  List<Notification>? notifications;
  int? count;

  NotificationsApiResponse({this.notifications, this.count});

  factory NotificationsApiResponse.fromJson(Map<String, dynamic> json) =>
      NotificationsApiResponse(
        notifications: json["notifications"] == null
            ? []
            : List<Notification>.from(
                json["notifications"]!.map((x) => Notification.fromJson(x)),
              ),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
    "notifications": notifications == null
        ? []
        : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "count": count,
  };
}

class Notification {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Data? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  Notification({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    type: json["type"],
    notifiableType: json["notifiable_type"],
    notifiableId: json["notifiable_id"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    readAt: json["read_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "data": data?.toJson(),
    "read_at": readAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  String getId() {
    return id ?? '';
  }
}

class Data {
  int? orderId;
  String? status;
  String? message;
  DateTime? updatedAt;

  Data({this.orderId, this.status, this.message, this.updatedAt});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderId: json["order_id"],
    status: json["status"],
    message: json["message"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "status": status,
    "message": message,
    "updated_at": updatedAt?.toIso8601String(),
  };

  String getMessage() {
    return message ?? '';
  }
}
