// To parse this JSON data, do
//
//     final addressListApiResponse = addressListApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:travel_clothing_club_flutter/app_modules/1_traveler/address/model/address_model.dart';

AddressListApiResponse addressListApiResponseFromJson(String str) =>
    AddressListApiResponse.fromJson(json.decode(str));

String addressListApiResponseToJson(AddressListApiResponse data) =>
    json.encode(data.toJson());

class AddressListApiResponse {
  String? message;
  List<Address>? addresses;

  AddressListApiResponse({this.message, this.addresses});

  factory AddressListApiResponse.fromJson(Map<String, dynamic> json) =>
      AddressListApiResponse(
        message: json["message"],
        addresses: json["addresses"] == null
            ? []
            : List<Address>.from(
                json["addresses"]!.map((x) => Address.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "addresses": addresses == null
        ? []
        : List<dynamic>.from(addresses!.map((x) => x.toJson())),
  };
}
