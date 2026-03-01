// To parse this JSON data, do
//
//     final placeOrderApiResponse = placeOrderApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/partner.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/models/refund_requests_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/auth_api_response.dart';

PlaceOrderApiResponse placeOrderApiResponseFromJson(String str) =>
    PlaceOrderApiResponse.fromJson(json.decode(str));

String placeOrderApiResponseToJson(PlaceOrderApiResponse data) =>
    json.encode(data.toJson());

class PlaceOrderApiResponse {
  bool? success;
  String? message;
  Data? data;
  ApiError? errors;

  PlaceOrderApiResponse({this.success, this.message, this.data, this.errors});

  factory PlaceOrderApiResponse.fromJson(Map<String, dynamic> json) {
    return PlaceOrderApiResponse(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      errors: json["errors"] == null ? null : ApiError.fromJson(json["errors"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "errors": errors?.toJson(),
  };
}

class ApiError {
  final String? message;
  final Errors? details;

  ApiError({this.message, this.details});

  factory ApiError.fromJson(dynamic json) {
    // Case 1: errors is a simple string
    if (json is String) {
      return ApiError(message: json);
    }

    // Case 2: errors is a map/object
    if (json is Map<String, dynamic>) {
      return ApiError(details: Errors.fromJson(json));
    }

    return ApiError();
  }

  Map<String, dynamic> toJson() {
    if (message != null) {
      return {"message": message};
    }
    return details?.toJson() ?? {};
  }
}

class Data {
  Order? order;

  Data({this.order});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(order: json["order"] == null ? null : Order.fromJson(json["order"]));

  Map<String, dynamic> toJson() => {"order": order?.toJson()};
}

class Order {
  int? id;
  String? orderId;
  int? travelerId;
  int? partnerId;
  dynamic totalPrice;
  String? status;
  List<Item>? items;
  Partner? partner;
  Traveler? traveler;
  dynamic createdAt;

  Order({
    this.id,
    this.orderId,
    this.travelerId,
    this.partnerId,
    this.totalPrice,
    this.status,
    this.items,
    this.partner,
    this.traveler,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    orderId: json["order_id"],
    travelerId: json["traveler_id"],
    partnerId: json["partner_id"],
    totalPrice: json["total_price"],
    status: json["status"],
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    partner: json["partner"] == null ? null : Partner.fromJson(json["partner"]),
    traveler: json["traveler"] == null
        ? null
        : Traveler.fromJson(json["traveler"]),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "traveler_id": travelerId,
    "partner_id": partnerId,
    "total_price": totalPrice,
    "status": status,
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "partner": partner?.toJson(),
    "traveler": traveler?.toJson(),
    "created_at": createdAt?.toIso8601String(),
  };
}

class Item {
  int? id;
  int? productId;
  String? size;
  int? quantity;
  dynamic price;
  dynamic total;
  Product? product;

  Item({
    this.id,
    this.productId,
    this.size,
    this.quantity,
    this.price,
    this.total,
    this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    productId: json["product_id"],
    size: json["size"],
    quantity: json["quantity"],
    price: json["price"],
    total: json["total"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "size": size,
    "quantity": quantity,
    "price": price,
    "total": total,
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? name;
  String? brand;

  Product({this.id, this.name, this.brand});

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(id: json["id"], name: json["name"], brand: json["brand"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "brand": brand};
}

// class Partner {
//   int? id;
//   String? businessName;
//
//   Partner({this.id, this.businessName});
//
//   factory Partner.fromJson(Map<String, dynamic> json) =>
//       Partner(id: json["id"], businessName: json["business_name"]);
//
//   Map<String, dynamic> toJson() => {"id": id, "business_name": businessName};
// }

// class Traveler {
//   int? id;
//   String? name;
//   String? email;
//
//   Traveler({this.id, this.name, this.email});
//
//   factory Traveler.fromJson(Map<String, dynamic> json) =>
//       Traveler(id: json["id"], name: json["name"], email: json["email"]);
//
//   Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email};
// }
