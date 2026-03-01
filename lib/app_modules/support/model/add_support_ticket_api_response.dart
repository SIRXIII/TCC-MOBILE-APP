// To parse this JSON data, do
//
//     final addSupportTicketApiResponse = addSupportTicketApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:travel_clothing_club_flutter/app_modules/support/model/support_ticket_api_response.dart';

AddSupportTicketApiResponse addSupportTicketApiResponseFromJson(String str) =>
    AddSupportTicketApiResponse.fromJson(json.decode(str));

String addSupportTicketApiResponseToJson(AddSupportTicketApiResponse data) =>
    json.encode(data.toJson());

class AddSupportTicketApiResponse {
  bool? success;
  String? message;
  SupportTicketModel? data;

  AddSupportTicketApiResponse({this.success, this.message, this.data});

  factory AddSupportTicketApiResponse.fromJson(Map<String, dynamic> json) =>
      AddSupportTicketApiResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : SupportTicketModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}
