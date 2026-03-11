// To parse this JSON data, do
//
//     final riderDeliveriesApiResponse = riderDeliveriesApiResponseFromJson(jsonString);

import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/order_status.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/orders_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/partner.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/auth_api_response.dart';

import '../../../../utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/extensions/string+ext.dart';

RiderDeliveriesApiResponse riderDeliveriesApiResponseFromJson(String str) =>
    RiderDeliveriesApiResponse.fromJson(json.decode(str));

String riderDeliveriesApiResponseToJson(RiderDeliveriesApiResponse data) =>
    json.encode(data.toJson());

class RiderDeliveriesApiResponse {
  bool? status;
  int? orderCount;
  List<Deliveries>? data;

  RiderDeliveriesApiResponse({this.status, this.orderCount, this.data});

  factory RiderDeliveriesApiResponse.fromJson(Map<String, dynamic> json) =>
      RiderDeliveriesApiResponse(
        status: json["status"],
        orderCount: json["order_count"],
        data: json["data"] == null
            ? []
            : List<Deliveries>.from(
                json["data"]!.map((x) => Deliveries.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "order_count": orderCount,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Deliveries {
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
  String? dispatchTime;
  String? deliveryTime;
  String? riderName;
  String? riderPhoto;
  dynamic ticketId;
  int? complaints;
  List<Items>? items;
  Partner? partner;
  Traveler? traveler;
  Rider? rider;

  Deliveries({
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
    this.ticketId,
    this.complaints,
    this.items,
    this.partner,
    this.traveler,
    this.rider,
  });

  factory Deliveries.fromJson(Map<String, dynamic> json) => Deliveries(
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
    ticketId: json["ticket_id"],
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
    "ticket_id": ticketId,
    "complaints": complaints,
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "partner": partner?.toJson(),
    "traveler": traveler?.toJson(),
    "rider": rider?.toJson(),
  };

  int getTicketId() {
    return ticketId ?? 0;
  }

  String getTravelerName() {
    return travelerName ?? '';
  }

  String getTravelerPhoto() {
    return travelerPhoto ?? '';
  }

  String getOrderId() {
    return orderId ?? '';
  }

  String getId() {
    return id.toString();
  }

  String getPickupBy() {
    if (getStaus() == OrderStatus.processing.value) {
      return '';
    } else if (getStaus() == OrderStatus.shipped.value ||
        getStaus() == OrderStatus.delivered.value ||
        getStaus() == OrderStatus.cancelled.value) {
      return dispatchTime?.toFormattedDispatchTime() ?? '';
    } else if (getStaus() == OrderStatus.return_requested.value) {
      return items?[0].getReturnDueDate() ?? '';
    }

    return createdAt ?? '';
  }

  bool isReturnsOrder() {

    if (getStaus() == OrderStatus.return_requested.value ||
        getStaus() == OrderStatus.returned.value) {
      return true;
    }

    return false;
  }

  String getStaus() {
    return OrderStatus.getStatusText(status ?? '');
  }

  String getPickupAddress() {
    if (isReturnsOrder()) {
      return traveler?.getAddress() ?? '';
    } else {
      return partner?.getAddress() ?? '';
    }
  }

  String getDropOffAddress() {
    if (isReturnsOrder()) {
      return partner?.getAddress() ?? '';
    } else {
      return traveler?.getAddress() ?? '';
    }
  }
}
