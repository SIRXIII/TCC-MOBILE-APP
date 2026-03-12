// To parse this JSON data, do
//
//     final orderApiResponse = orderApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/order_status.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/partner.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/auth_api_response.dart';
import 'package:travel_clothing_club_flutter/utils/extensions/string+ext.dart';

OrderApiResponse orderApiResponseFromJson(String str) =>
    OrderApiResponse.fromJson(json.decode(str));

String orderApiResponseToJson(OrderApiResponse data) =>
    json.encode(data.toJson());

class OrderApiResponse {
  bool? success;
  String? message;
  Data? data;

  OrderApiResponse({this.success, this.message, this.data});

  factory OrderApiResponse.fromJson(Map<String, dynamic> json) =>
      OrderApiResponse(
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
  List<Order>? orders;

  Data({this.orders});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orders: json["orders"] == null
        ? []
        : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orders": orders == null
        ? []
        : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  int? id;
  String? orderId;
  String? travelerName;
  String? travelerPhoto;
  String? partnerName;
  String? partnerPhoto;
  int? itemsCount;
  String? totalPrice;
  String? status;
  String? createdAt;
  String? dispatchTime;
  String? deliveryTime;
  String? returnTime;
  String? riderName;
  String? riderPhoto;
  int? complaints;
  dynamic ticketId;
  List<Items>? items;
  CanceledBy? canceledBy;
  Partner? partner;
  Traveler? traveler;
  Rider? rider;

  Order({
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
    this.returnTime,
    this.riderName,
    this.riderPhoto,
    this.ticketId,
    this.complaints,
    this.items,
    this.canceledBy,
    this.partner,
    this.traveler,
    this.rider,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
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
    returnTime: json["return_time"],
    riderName: json["rider_name"],
    riderPhoto: json["rider_photo"],
    ticketId: json["ticket_id"],
    complaints: json["complaints"],
    items: json["items"] == null
        ? []
        : List<Items>.from(json["items"]!.map((x) => Items.fromJson(x))),
    canceledBy: json["canceled_by"] == null
        ? null
        : CanceledBy.fromJson(json["canceled_by"]),
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
    "return_time": returnTime,
    "rider_name": riderName,
    "rider_photo": riderPhoto,
    "ticket_id": ticketId,
    "complaints": complaints,
    "items": items == null ? [] : List<Items>.from(items!.map((x) => x)),
    "canceled_by": canceledBy?.toJson(),
    "partner": partner?.toJson(),
    "traveler": traveler?.toJson(),
    "rider": rider?.toJson(),
  };

  int getId() {
    return id ?? 0;
  }

  // int getTicketId() {
  //   return ticketId ?? 0;
  // }

  int getTicketId() {
    final value = ticketId;

    if (value == null) return 0;

    // If already int
    if (value is int) {
      return value;
    }

    // If string (e.g. "9", "0009", "TCK-0009")
    if (value is String) {
      // final match = RegExp(r'\d+').firstMatch(value);
      return int.parse(extractTicketIdString(value));
    }

    // Fallback for any unexpected type
    return 0;
  }

  String getStatus() {
    return status ?? '';
  }

  String getPrice() {
    return totalPrice ?? '';
  }

  String gePartnerName() {
    return partnerName ?? '';
  }

  String getOrderId() {
    return id.toString() ?? '';
  }

  String getOrderIdName() {
    return orderId.toString() ?? '';
  }

  String getPendingDate() {
    return createdAt ?? 'N/A';
  }

  String getDispatchTime() {
    return dispatchTime?.toFormattedDispatchTime() ?? 'N/A';
  }

  String getDeliveryTime() {
    return deliveryTime?.toFormattedDispatchTime() ?? 'N/A';
  }

  String getReturnTime() {
    return returnTime?.toFormattedDispatchTime() ?? 'N/A';
  }

  bool showRefundButton() {
    if (status == OrderStatus.returned.value) {
      return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'Order{id: $id, travelerName: $travelerName, travelerPhoto: $travelerPhoto, partnerName: $partnerName, partnerPhoto: $partnerPhoto, itemsCount: $itemsCount, totalPrice: $totalPrice, status: $status, createdAt: $createdAt, dispatchTime: $dispatchTime, deliveryTime: $deliveryTime, riderName: $riderName, riderPhoto: $riderPhoto, complaints: $complaints, items: $items, canceledBy: $canceledBy, partner: $partner, traveler: $traveler, rider: $rider}';
  }

  String extractTicketIdString(String ticketId) {
    final match = RegExp(r'\d+').firstMatch(ticketId);
    return match?.group(0) ?? '';
  }
}

class CanceledBy {
  String? type;
  String? name;

  CanceledBy({this.type, this.name});

  factory CanceledBy.fromJson(Map<String, dynamic> json) =>
      CanceledBy(type: json["type"], name: json["name"]);

  Map<String, dynamic> toJson() => {"type": type, "name": name};
}

class Items {
  int? id;
  int? productId;
  String? productName;
  String? productImage;
  int? quantity;
  String? price;
  String? total;
  String? size;
  int? rentalDays;
  String? returnDueDate;
  dynamic returnedAt;

  Items({
    this.id,
    this.productId,
    this.productName,
    this.productImage,
    this.quantity,
    this.price,
    this.total,
    this.size,
    this.rentalDays,
    this.returnDueDate,
    this.returnedAt,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["id"],
    productId: json["product_id"],
    productName: json["product_name"],
    productImage: json["product_image"],
    quantity: json["quantity"],
    price: json["price"],
    total: json["total"],
    size: json["size"],
    rentalDays: json["rental_days"],
    returnDueDate: json["return_due_date"],
    returnedAt: json["returned_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "product_image": productImage,
    "quantity": quantity,
    "price": price,
    "total": total,
    "size": size,
    "rental_days": rentalDays,
    "return_due_date": returnDueDate,
    "returned_at": returnedAt,
  };

  String getName() {
    return productName ?? '';
  }

  String getReturnDueDate() {
    return returnDueDate ?? '';
  }

  String getImage() {
    return productImage ?? '';
  }

  String getSize() {
    return size ?? '';
  }

  String getPrice() {
    return total ?? '';
  }

  String getRentalDays() {
    if (rentalDays != null) {
      if (rentalDays! > 1) {
        return '$rentalDays Days';
      }
      return '$rentalDays Day';
    }
    return '$rentalDays';
  }

  String getProductPrice() {
    return '$price';
  }

  String getProductPriceWithCurrency() {
    return '\$$price';
  }
}
