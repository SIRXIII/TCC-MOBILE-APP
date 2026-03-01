// To parse this JSON data, do
//
//     final productsApiResponse = productsApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:travel_clothing_club_flutter/app_modules/1_traveler/home/models/product_model.dart';

ProductsApiResponse productsApiResponseFromJson(String str) =>
    ProductsApiResponse.fromJson(json.decode(str));

String productsApiResponseToJson(ProductsApiResponse data) =>
    json.encode(data.toJson());

class ProductsApiResponse {
  bool? success;
  String? message;
  Data? data;

  ProductsApiResponse({this.success, this.message, this.data});

  factory ProductsApiResponse.fromJson(Map<String, dynamic> json) =>
      ProductsApiResponse(
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
  List<Product>? products;
  Pagination? pagination;

  Data({this.products, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: json["products"] == null
        ? []
        : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null
        ? []
        : List<dynamic>.from(products!.map((x) => x.toJson())),
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
  String? nextPageUrl;
  dynamic prevPageUrl;

  Pagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
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
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };
}


