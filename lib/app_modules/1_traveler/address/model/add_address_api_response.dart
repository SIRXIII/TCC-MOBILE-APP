// To parse this JSON data, do
//
//     final addAddressApiResponse = addAddressApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/model/address_model.dart';

AddAddressApiResponse addAddressApiResponseFromJson(String str) =>
    AddAddressApiResponse.fromJson(json.decode(str));

String addAddressApiResponseToJson(AddAddressApiResponse data) =>
    json.encode(data.toJson());

class AddAddressApiResponse {
  String? message;
  Address? address;

  AddAddressApiResponse({this.message, this.address});

  factory AddAddressApiResponse.fromJson(Map<String, dynamic> json) =>
      AddAddressApiResponse(
        message: json["message"],
        address: json["address"] == null
            ? null
            : Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "address": address?.toJson(),
  };
}
