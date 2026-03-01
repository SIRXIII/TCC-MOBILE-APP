// To parse this JSON data, do
//
//     final updateOrderApiResponse = updateOrderApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/orders_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/partner.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/auth_api_response.dart';


UpdateOrderApiResponse updateOrderApiResponseFromJson(String str) =>
    UpdateOrderApiResponse.fromJson(json.decode(str));

String updateOrderApiResponseToJson(UpdateOrderApiResponse data) =>
    json.encode(data.toJson());

class UpdateOrderApiResponse {
  bool? status;
  String? message;
  Data? data;
  List<Data>? orders;

  UpdateOrderApiResponse({this.status, this.message, this.data, this.orders});

  factory UpdateOrderApiResponse.fromJson(Map<String, dynamic> json) =>
      UpdateOrderApiResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        orders: json["orders"] == null
            ? []
            : List<Data>.from(json["orders"]!.map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "orders": orders == null
        ? []
        : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Data {
  int? id;
  String? orderId;
  String? travelerName;
  String? travelerPhoto;
  String? partnerName;
  dynamic partnerPhoto;
  int? itemsCount;
  String? totalPrice;
  String? status;
  String? createdAt;
  dynamic dispatchTime;
  dynamic deliveryTime;
  dynamic riderName;
  dynamic riderPhoto;
  int? complaints;
  List<Items>? items;
  Partner? partner;
  Traveler? traveler;
  Rider? rider;

  Data({
    this.id,
    this.orderId,
    this.travelerName,
    this.travelerPhoto,
    this.partnerName,
    this.partnerPhoto,
    this.itemsCount,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.dispatchTime,
    this.deliveryTime,
    this.riderName,
    this.riderPhoto,
    this.complaints,
    this.items,
    this.partner,
    this.traveler,
    this.rider,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    orderId: json["order_id"],
    travelerName: json["traveler_name"],
    travelerPhoto: json["traveler_photo"],
    partnerName: json["partner_name"],
    partnerPhoto: json["partner_photo"],
    itemsCount: json["items_count"],
    totalPrice: json["total_price"],
    status: json["status"],
    createdAt: json["created_at"],
    dispatchTime: json["dispatch_time"],
    deliveryTime: json["delivery_time"],
    riderName: json["rider_name"],
    riderPhoto: json["rider_photo"],
    complaints: json["complaints"],
    items: json["items"] == null
        ? []
        : List<Items>.from(json["items"]!.map((x) => Items.fromJson(x))),
    partner: json["partner"] == null ? null : Partner.fromJson(json["partner"]),
    traveler: json["traveler"] == null
        ? null
        : Traveler.fromJson(json["traveler"]),
    rider: json["rider"] == null ? null : Rider.fromJson(json["rider"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "traveler_name": travelerName,
    "traveler_photo": travelerPhoto,
    "partner_name": partnerName,
    "partner_photo": partnerPhoto,
    "items_count": itemsCount,
    "total_price": totalPrice,
    "status": status,
    "created_at": createdAt,
    "dispatch_time": dispatchTime,
    "delivery_time": deliveryTime,
    "rider_name": riderName,
    "rider_photo": riderPhoto,
    "complaints": complaints,
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "partner": partner?.toJson(),
    "traveler": traveler?.toJson(),
    "rider": rider?.toJson(),
  };
}
