// To parse this JSON data, do
//
//     final authApiResponse = authApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/models/refund_requests_api_response.dart';

AuthApiResponse authApiResponseFromJson(String str) =>
    AuthApiResponse.fromJson(json.decode(str));

String authApiResponseToJson(AuthApiResponse data) =>
    json.encode(data.toJson());

class AuthApiResponse {
  bool? success;
  String? message;
  UserData? data;
  Errors? errors;

  AuthApiResponse({this.success, this.message, this.data, this.errors});

  factory AuthApiResponse.fromJson(Map<String, dynamic> json) =>
      AuthApiResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "errors": errors?.toJson(),
  };
}

class UserData {
  Traveler? traveler;
  Rider? rider;
  String? token;

  UserData({this.traveler, this.rider, this.token});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    traveler: json["traveler"] == null
        ? null
        : Traveler.fromJson(json["traveler"]),
    rider: json["rider"] == null ? null : Rider.fromJson(json["rider"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "traveler": traveler?.toJson(),
    "rider": rider?.toJson(),
    "token": token,
  };

  // --> getAuthToken
  String getAuthToken() {
    if (token != null && token != '') {
      return 'Bearer $token';
    }
    return 'Bearer ee';
  }

  String getEmail() {
    if (rider != null) {
      return rider?.getEmail() ?? '';
    } else if (traveler != null) {
      return traveler?.getEmail() ?? '';
    }
    return '';
  }
}

// class Traveler {
//   int? id;
//   String? name;
//   String? email;
//   DateTime? emailVerifiedAt;
//   String? status;
//   String? type;
//   String? profileImage;
//
//   Traveler({
//     this.id,
//     this.name,
//     this.email,
//     this.emailVerifiedAt,
//     this.status,
//     this.type,
//     this.profileImage,
//   });
//
//   factory Traveler.fromJson(Map<String, dynamic> json) => Traveler(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     emailVerifiedAt: json["email_verified_at"] == null
//         ? null
//         : DateTime.parse(json["email_verified_at"]),
//     status: json["status"],
//     type: json["type"],
//     profileImage: json["image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "email_verified_at": emailVerifiedAt?.toIso8601String(),
//     "status": status,
//     "type": type,
//     "image": profileImage,
//   };
//
//   String getName() {
//     return name ?? '';
//   }
//
//   String getEmail() {
//     return email ?? '';
//   }
// }

class Traveler {
  int? id;
  String? profilePhoto;
  dynamic avatar;
  String? name;
  dynamic username;
  String? email;
  DateTime? emailVerifiedAt;
  dynamic phone;
  String? country;
  String? city;
  String? postalCode;
  dynamic address;
  String? gender;
  String? size;
  dynamic dateOfBirth;
  dynamic spentAmount;
  String? status;
  dynamic provider;
  String? createdAt;
  DateTime? updatedAt;
  String? lastActive;
  dynamic totalOrders;
  dynamic totalAmountSpent;
  String? type;
  String? profileImage;

  Traveler({
    this.id,
    this.profilePhoto,
    this.avatar,
    this.name,
    this.username,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.country,
    this.city,
    this.postalCode,
    this.address,
    this.gender,
    this.size,
    this.dateOfBirth,
    this.spentAmount,
    this.status,
    this.provider,
    this.createdAt,
    this.updatedAt,
    this.lastActive,
    this.totalOrders,
    this.totalAmountSpent,
    this.type,
    this.profileImage,
  });

  factory Traveler.fromJson(Map<String, dynamic> json) => Traveler(
    id: json["id"],
    profilePhoto: json["profile_photo"],
    avatar: json["avatar"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
    phone: json["phone"],
    country: json["country"],
    city: json["city"],
    postalCode: json["postal_code"],
    address: json["address"],
    gender: json["gender"],
    size: json["size"],
    dateOfBirth: json["date_of_birth"],
    spentAmount: json["spent_amount"],
    status: json["status"],
    provider: json["provider"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    lastActive: json["last_active"],
    totalOrders: json["total_orders"],
    totalAmountSpent: json["total_amount_spent"],
    type: json["type"],
    profileImage: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_photo": profilePhoto,
    "avatar": avatar,
    "name": name,
    "username": username,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "phone": phone,
    "country": country,
    "city": city,
    "postal_code": postalCode,
    "address": address,
    "gender": gender,
    "size": size,
    "date_of_birth": dateOfBirth,
    "spent_amount": spentAmount,
    "status": status,
    "provider": provider,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "last_active": lastActive,
    "total_orders": totalOrders,
    "total_amount_spent": totalAmountSpent,
    "type": type,
    "image": profileImage,
  };

  bool isSocialLogged() {
    return provider != null && provider != '';
  }

  String getId() {
    return id?.toString() ?? '';
  }

  int getUserId() {
    return id ?? 0;
  }

  String getName() {
    return name ?? '';
  }

  String getAddress() {
    return address ?? '';
  }

  String getEmail() {
    return email ?? '';
  }

  String getSize() {
    return size ?? '';
  }

  String getProfilePhoto() {
    return profilePhoto ?? '';
  }

  String getLocation() {
    return '$city, $country';
  }

  String getGender() {
    if (gender == null) {
      return '';
    }
    return '$gender'.capitalizeFirst ?? '';
  }

  int getTravelerId() {
    return id ?? 0;
  }
}

class Rider {
  int? id;
  String? riderId;
  String? name;
  String? firstName;
  String? lastName;
  dynamic phone;
  String? email;
  DateTime? emailVerifiedAt;
  dynamic address;
  dynamic latitude;
  dynamic longitude;
  dynamic profilePhoto;
  dynamic avatar;
  dynamic provider;
  String? licenseStatus;
  Documents? documents;
  dynamic licensePlate;
  dynamic vehicleType;
  dynamic vehicleName;
  dynamic assignedRegion;
  String? insurance;
  dynamic insuranceExpireDate;
  String? availabilityStatus;
  String? status;
  dynamic rating;
  int? reviewsCount;
  List<dynamic>? commonComplaints;
  dynamic latestComplaint;
  int? pendingOrdersCount;
  int? cancelledOrdersCount;
  int? deliveredOrdersCount;
  String? averageDeliveryTime;
  int? currentAssignedOrders;
  String? type;

  Rider({
    this.id,
    this.riderId,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.address,
    this.latitude,
    this.longitude,
    this.profilePhoto,
    this.avatar,
    this.provider,
    this.licenseStatus,
    this.documents,
    this.licensePlate,
    this.vehicleType,
    this.vehicleName,
    this.assignedRegion,
    this.insurance,
    this.insuranceExpireDate,
    this.availabilityStatus,
    this.status,
    this.rating,
    this.reviewsCount,
    this.commonComplaints,
    this.latestComplaint,
    this.pendingOrdersCount,
    this.cancelledOrdersCount,
    this.deliveredOrdersCount,
    this.averageDeliveryTime,
    this.currentAssignedOrders,
    this.type,
  });

  factory Rider.fromJson(Map<String, dynamic> json) => Rider(
    id: json["id"],
    riderId: json["rider_id"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    profilePhoto: json["profile_photo"],
    avatar: json["avatar"],
    provider: json["provider"],
    licenseStatus: json["license_status"],
    documents: json["documents"] == null
        ? null
        : Documents.fromJson(json["documents"]),
    licensePlate: json["license_plate"],
    vehicleType: json["vehicle_type"],
    vehicleName: json["vehicle_name"],
    assignedRegion: json["assigned_region"],
    insurance: json["insurance"],
    insuranceExpireDate: json["insurance_expire_date"],
    availabilityStatus: json["availability_status"],
    status: json["status"],
    rating: json["rating"],
    reviewsCount: json["reviews_count"],
    commonComplaints: json["common_complaints"] == null
        ? []
        : List<dynamic>.from(json["common_complaints"]!.map((x) => x)),
    latestComplaint: json["latest_complaint"],
    pendingOrdersCount: json["pending_orders_count"],
    cancelledOrdersCount: json["cancelled_orders_count"],
    deliveredOrdersCount: json["delivered_orders_count"],
    averageDeliveryTime: json["average_delivery_time"],
    currentAssignedOrders: json["current_assigned_orders"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rider_id": riderId,
    "name": name,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "profile_photo": profilePhoto,
    "avatar": avatar,
    "provider": provider,
    "license_status": licenseStatus,
    "documents": documents?.toJson(),
    "license_plate": licensePlate,
    "vehicle_type": vehicleType,
    "vehicle_name": vehicleName,
    "assigned_region": assignedRegion,
    "insurance": insurance,
    "insurance_expire_date": insuranceExpireDate,
    "availability_status": availabilityStatus,
    "status": status,
    "rating": rating,
    "reviews_count": reviewsCount,
    "common_complaints": commonComplaints == null
        ? []
        : List<dynamic>.from(commonComplaints!.map((x) => x)),
    "latest_complaint": latestComplaint,
    "pending_orders_count": pendingOrdersCount,
    "cancelled_orders_count": cancelledOrdersCount,
    "delivered_orders_count": deliveredOrdersCount,
    "average_delivery_time": averageDeliveryTime,
    "current_assigned_orders": currentAssignedOrders,
    "type": type,
  };

  bool isSocialLogged() {
    return provider != null && provider != '';
  }

  String getId() {
    return id.toString();
  }

  int getUserId() {
    return id ?? 0;
  }

  String getRiderId() {
    return riderId.toString();
  }

  String getName() {
    return name ?? '';
  }

  String getEmail() {
    return email ?? '';
  }

  String getProfilePhoto() {
    return profilePhoto ?? '';
  }

  String getLocation() {
    return '$address';
  }

  void setLocation(String newLocation) {
    address = newLocation;
  }

  String getRating() {
    // debugPrint('getRating() called with rating: $rating');

    if (rating == null) {
      return '';
    }
    return rating.toString();
  }
}

class Documents {
  dynamic licenseFront;
  dynamic licenseBack;

  Documents({this.licenseFront, this.licenseBack});

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
    licenseFront: json["license_front"],
    licenseBack: json["license_back"],
  );

  Map<String, dynamic> toJson() => {
    "license_front": licenseFront,
    "license_back": licenseBack,
  };
}
