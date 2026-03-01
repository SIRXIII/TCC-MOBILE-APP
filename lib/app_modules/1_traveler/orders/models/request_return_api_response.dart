// To parse this JSON data, do
//
//     final requestReturnApiResponse = requestReturnApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/orders_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/partner.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/auth_api_response.dart';

RequestReturnApiResponse requestReturnApiResponseFromJson(String str) =>
    RequestReturnApiResponse.fromJson(json.decode(str));

String requestReturnApiResponseToJson(RequestReturnApiResponse data) =>
    json.encode(data.toJson());

class RequestReturnApiResponse {
  bool? success;
  String? message;
  Data? data;

  RequestReturnApiResponse({this.success, this.message, this.data});

  factory RequestReturnApiResponse.fromJson(Map<String, dynamic> json) =>
      RequestReturnApiResponse(
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
  Return? dataReturn;

  Data({this.dataReturn});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dataReturn: json["return"] == null ? null : Return.fromJson(json["return"]),
  );

  Map<String, dynamic> toJson() => {"return": dataReturn?.toJson()};
}

class Return {
  int? id;
  String? returnId;
  String? status;
  String? pickupAddress;
  DateTime? pickupTime;
  String? returnDueDate;
  String? scheduledAt;
  dynamic completedAt;
  Product? product;
  Order? order;
  Traveler? traveler;
  Partner? partner;
  String? createdAt;
  String? updatedAt;

  Return({
    this.id,
    this.returnId,
    this.status,
    this.pickupAddress,
    this.pickupTime,
    this.returnDueDate,
    this.scheduledAt,
    this.completedAt,
    this.product,
    this.order,
    this.traveler,
    this.partner,
    this.createdAt,
    this.updatedAt,
  });

  factory Return.fromJson(Map<String, dynamic> json) => Return(
    id: json["id"],
    returnId: json["return_id"],
    status: json["status"],
    pickupAddress: json["pickup_address"],
    pickupTime: json["pickup_time"] == null
        ? null
        : DateTime.parse(json["pickup_time"]),
    returnDueDate: json["return_due_date"],
    scheduledAt: json["scheduled_at"],
    completedAt: json["completed_at"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    traveler: json["traveler"] == null
        ? null
        : Traveler.fromJson(json["traveler"]),
    partner: json["partner"] == null ? null : Partner.fromJson(json["partner"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "return_id": returnId,
    "status": status,
    "pickup_address": pickupAddress,
    "pickup_time": pickupTime?.toIso8601String(),
    "return_due_date": returnDueDate,
    "scheduled_at": scheduledAt,
    "completed_at": completedAt,
    "product": product?.toJson(),
    "order": order?.toJson(),
    "traveler": traveler?.toJson(),
    "partner": partner?.toJson(),
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
