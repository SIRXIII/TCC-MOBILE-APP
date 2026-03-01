// To parse this JSON data, do
//
//     final refundRequestsApiResponse = refundRequestsApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/orders_api_response.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/partner.dart';
import 'package:travel_clothing_club_flutter/app_modules/auth/model/auth_api_response.dart';

// To parse this JSON data, do
//
//     final refundRequestsApiResponse = refundRequestsApiResponseFromJson(jsonString);


RefundRequestsApiResponse refundRequestsApiResponseFromJson(String str) =>
    RefundRequestsApiResponse.fromJson(json.decode(str));

String refundRequestsApiResponseToJson(RefundRequestsApiResponse data) =>
    json.encode(data.toJson());

class RefundRequestsApiResponse {
  bool? success;
  String? message;
  Data? data;
  Errors? errors;

  RefundRequestsApiResponse({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory RefundRequestsApiResponse.fromJson(Map<String, dynamic> json) =>
      RefundRequestsApiResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "errors": errors?.toJson(),
  };
}

class Data {
  List<Refund>? refunds;
  Pagination? pagination;

  Data({this.refunds, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    refunds: json["refunds"] == null
        ? []
        : List<Refund>.from(json["refunds"]!.map((x) => Refund.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "refunds": refunds == null
        ? []
        : List<dynamic>.from(refunds!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  int? from;
  int? to;
  String? path;
  dynamic nextPageUrl;
  dynamic prevPageUrl;

  Pagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
    this.path,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    from: json["from"],
    to: json["to"],
    path: json["path"],
    nextPageUrl: json["next_page_url"],
    prevPageUrl: json["prev_page_url"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
    "from": from,
    "to": to,
    "path": path,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };
}

class Refund {
  int? id;
  int? orderId;
  String? refundId;
  String? reason;
  String? status;
  String? requestedAt;
  String? resolvedAt;
  String? amount;
  dynamic comments;
  Order? order;
  Traveler? traveler;
  Partner? partner;
  List<dynamic>? images;

  Refund({
    this.id,
    this.orderId,
    this.refundId,
    this.reason,
    this.status,
    this.requestedAt,
    this.resolvedAt,
    this.amount,
    this.comments,
    this.order,
    this.traveler,
    this.partner,
    this.images,
  });

  factory Refund.fromJson(Map<String, dynamic> json) => Refund(
    id: json["id"],
    orderId: json["order_id"],
    refundId: json["refund_id"],
    reason: json["reason"],
    status: json["status"],
    requestedAt: json["requested_at"],
    resolvedAt: json["resolved_at"],
    amount: json["amount"],
    comments: json["comments"],
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    traveler: json["traveler"] == null
        ? null
        : Traveler.fromJson(json["traveler"]),
    partner: json["partner"] == null ? null : Partner.fromJson(json["partner"]),
    images: json["images"] == null
        ? []
        : List<dynamic>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "refund_id": refundId,
    "reason": reason,
    "status": status,
    "requested_at": requestedAt,
    "resolved_at": resolvedAt,
    "amount": amount,
    "comments": comments,
    "order": order?.toJson(),
    "traveler": traveler?.toJson(),
    "partner": partner?.toJson(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };

  // String getRefundId() {
  //   return id?.toString() ?? '';
  // }

  String getStatus() {
    return status ?? '';
  }

  String getAmount() {
    return amount ?? '';
  }

  String getRefundId() {
    return refundId ?? '';
  }

  String getOrderId() {
    return orderId?.toString() ?? '';
  }

  String getRequestedAt() {
    return requestedAt ?? '';
  }

  String getReason() {
    return reason ?? '';
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
  dynamic rider;

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
    this.riderName,
    this.riderPhoto,
    this.complaints,
    this.items,
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
    rider: json["rider"],
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
    "rider": rider,
  };

  String getTotalPrice() {
    return totalPrice ?? '';
  }

  String getOrderId() {
    return orderId ?? '';
  }
}

// class Item {
//   int? id;
//   int? productId;
//   String? productName;
//   String? productImage;
//   int? quantity;
//   String? price;
//   String? total;
//   String? size;
//   int? rentalDays;
//   String? returnDueDate;
//   dynamic returnedAt;
//
//   Item({
//     this.id,
//     this.productId,
//     this.productName,
//     this.productImage,
//     this.quantity,
//     this.price,
//     this.total,
//     this.size,
//     this.rentalDays,
//     this.returnDueDate,
//     this.returnedAt,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//     id: json["id"],
//     productId: json["product_id"],
//     productName: json["product_name"],
//     productImage: json["product_image"],
//     quantity: json["quantity"],
//     price: json["price"],
//     total: json["total"],
//     size: json["size"],
//     rentalDays: json["rental_days"],
//     returnDueDate: json["return_due_date"],
//     returnedAt: json["returned_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "product_name": productName,
//     "product_image": productImage,
//     "quantity": quantity,
//     "price": price,
//     "total": total,
//     "size": size,
//     "rental_days": rentalDays,
//     "return_due_date": returnDueDate,
//     "returned_at": returnedAt,
//   };
//
//   String getImage() {
//     return productImage ?? '';
//   }
//
//   String getName() {
//     return productName ?? '';
//   }
//
//   String getReturnDueDate() {
//     return returnDueDate ?? '';
//   }
//
//   String getSize() {
//     return size ?? '';
//   }
//
//   String getRentalDays() {
//     return '${rentalDays.toString()} Days';
//   }
//
//   String getProductPrice() {
//     return '$price';
//   }
//
//   String getProductPriceWithCurrency() {
//     return '\$$price';
//   }
// }

class Availability {
  Day? friday;
  Day? monday;
  Day? sunday;
  Day? tuesday;
  Day? saturday;
  Day? thursday;
  Day? wednesday;

  Availability({
    this.friday,
    this.monday,
    this.sunday,
    this.tuesday,
    this.saturday,
    this.thursday,
    this.wednesday,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    friday: json["Friday"] == null ? null : Day.fromJson(json["Friday"]),
    monday: json["Monday"] == null ? null : Day.fromJson(json["Monday"]),
    sunday: json["Sunday"] == null ? null : Day.fromJson(json["Sunday"]),
    tuesday: json["Tuesday"] == null ? null : Day.fromJson(json["Tuesday"]),
    saturday: json["Saturday"] == null ? null : Day.fromJson(json["Saturday"]),
    thursday: json["Thursday"] == null ? null : Day.fromJson(json["Thursday"]),
    wednesday: json["Wednesday"] == null
        ? null
        : Day.fromJson(json["Wednesday"]),
  );

  Map<String, dynamic> toJson() => {
    "Friday": friday?.toJson(),
    "Monday": monday?.toJson(),
    "Sunday": sunday?.toJson(),
    "Tuesday": tuesday?.toJson(),
    "Saturday": saturday?.toJson(),
    "Thursday": thursday?.toJson(),
    "Wednesday": wednesday?.toJson(),
  };
}

class Day {
  bool? checked;
  String? endTime;
  String? startTime;

  Day({this.checked, this.endTime, this.startTime});

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    checked: json["checked"],
    endTime: json["end_time"],
    startTime: json["start_time"],
  );

  Map<String, dynamic> toJson() => {
    "checked": checked,
    "end_time": endTime,
    "start_time": startTime,
  };
}

class Documents {
  List<License>? license;
  List<dynamic>? ownerIdCard;

  Documents({this.license, this.ownerIdCard});

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
    license: json["license"] == null
        ? []
        : List<License>.from(json["license"]!.map((x) => License.fromJson(x))),
    ownerIdCard: json["owner_id_card"] == null
        ? []
        : List<dynamic>.from(json["owner_id_card"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "license": license == null
        ? []
        : List<dynamic>.from(license!.map((x) => x.toJson())),
    "owner_id_card": ownerIdCard == null
        ? []
        : List<dynamic>.from(ownerIdCard!.map((x) => x)),
  };
}

class License {
  String? side;
  String? filePath;

  License({this.side, this.filePath});

  factory License.fromJson(Map<String, dynamic> json) =>
      License(side: json["side"], filePath: json["file_path"]);

  Map<String, dynamic> toJson() => {"side": side, "file_path": filePath};
}

class Errors {
  List<String>? email;
  List<String>? partnerId;
  List<String>? orderId;
  List<String>? reason;
  List<String>? items0Size;
  List<String>? dob;
  List<String>? new_password;

  Errors({
    this.email,
    this.partnerId,
    this.orderId,
    this.reason,
    this.items0Size,
    this.dob,
    this.new_password,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    email: json["email"] == null
        ? []
        : List<String>.from(json["email"]!.map((x) => x)),
    partnerId: json["partner_id"] == null
        ? []
        : List<String>.from(json["partner_id"]!.map((x) => x)),
    orderId: json["order_id"] == null
        ? []
        : List<String>.from(json["order_id"]!.map((x) => x)),
    reason: json["reason"] == null
        ? []
        : List<String>.from(json["reason"]!.map((x) => x)),
    items0Size: json["items.0.size"] == null
        ? []
        : List<String>.from(json["items.0.size"]!.map((x) => x)),

    dob: json["date_of_birth"] == null
        ? []
        : List<String>.from(json["date_of_birth"]!.map((x) => x)),
    new_password: json["new_password"] == null
        ? []
        : List<String>.from(json["new_password"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),

    "partner_id": partnerId == null
        ? []
        : List<dynamic>.from(partnerId!.map((x) => x)),
    "order_id": orderId == null
        ? []
        : List<dynamic>.from(orderId!.map((x) => x)),
    "reason": reason == null ? [] : List<dynamic>.from(reason!.map((x) => x)),
    "items.0.size": items0Size == null
        ? []
        : List<dynamic>.from(items0Size!.map((x) => x)),
    "date_of_birth": dob == null ? [] : List<dynamic>.from(dob!.map((x) => x)),
    "new_password": dob == null ? [] : List<dynamic>.from(dob!.map((x) => x)),
  };

  String getAllErrors() {
    final List<String> errors = [];

    if (partnerId != null && partnerId!.isNotEmpty) {
      errors.addAll(partnerId!);
    }
    if (orderId != null && orderId!.isNotEmpty) {
      errors.addAll(orderId!);
    }
    if (reason != null && reason!.isNotEmpty) {
      errors.addAll(reason!);
    }
    if (items0Size != null && items0Size!.isNotEmpty) {
      errors.addAll(items0Size!);
    }
    if (dob != null && dob!.isNotEmpty) {
      errors.addAll(dob!);
    }

    if (new_password != null && new_password!.isNotEmpty) {
      errors.addAll(new_password!);
    }

    if (email != null && email!.isNotEmpty) {
      errors.addAll(email!);
    }
    return errors.isEmpty ? '' : errors.join('\n');
  }
}

// class Order {
//   int? id;
//   String? orderId;
//   int? totalPrice;
//   String? status;
//
//   Order({
//     this.id,
//     this.orderId,
//     this.totalPrice,
//     this.status,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//     id: json["id"],
//     orderId: json["order_id"],
//     totalPrice: json["total_price"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "order_id": orderId,
//     "total_price": totalPrice,
//     "status": status,
//   };
// }
//
// class Partner {
//   int? id;
//   String? businessName;
//
//   Partner({
//     this.id,
//     this.businessName,
//   });
//
//   factory Partner.fromJson(Map<String, dynamic> json) => Partner(
//     id: json["id"],
//     businessName: json["business_name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "business_name": businessName,
//   };
// }
//
// class Traveler {
//   int? id;
//   String? name;
//   String? email;
//
//   Traveler({
//     this.id,
//     this.name,
//     this.email,
//   });
//
//   factory Traveler.fromJson(Map<String, dynamic> json) => Traveler(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//   };
// }
