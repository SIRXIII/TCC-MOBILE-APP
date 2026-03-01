// To parse this JSON data, do
//
//     final updateApiResponse = updateApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:travel_clothing_club_flutter/app_modules/1_traveler/refund/models/refund_requests_api_response.dart';

UpdateApiResponse updateApiResponseFromJson(String str) =>
    UpdateApiResponse.fromJson(json.decode(str));

String updateApiResponseToJson(UpdateApiResponse data) =>
    json.encode(data.toJson());

class UpdateApiResponse {
  bool? success;
  String? message;
  Data? data;
  Errors? errors;

  UpdateApiResponse({this.success, this.message, this.data, this.errors});

  factory UpdateApiResponse.fromJson(Map<String, dynamic> json) =>
      UpdateApiResponse(
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
  Traveler? traveler;

  Data({this.traveler});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    traveler: json["traveler"] == null
        ? null
        : Traveler.fromJson(json["traveler"]),
  );

  Map<String, dynamic> toJson() => {"traveler": traveler?.toJson()};
}

class Traveler {
  String? name;
  String? gender;
  String? size;
  DateTime? dateOfBirth;
  String? profilePhoto;
  String? phone;

  Traveler({
    this.name,
    this.gender,
    this.size,
    this.dateOfBirth,
    this.profilePhoto,
    this.phone,
  });

  factory Traveler.fromJson(Map<String, dynamic> json) => Traveler(
    name: json["name"],
    gender: json["gender"],
    size: json["size"],
    dateOfBirth: json["date_of_birth"] == null
        ? null
        : DateTime.parse(json["date_of_birth"]),
    profilePhoto: json["profile_photo"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "gender": gender,
    "size": size,
    "date_of_birth":
        "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "profile_photo": profilePhoto,
    "phone": phone,
  };
}
