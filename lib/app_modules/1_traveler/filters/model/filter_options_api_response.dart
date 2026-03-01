// To parse this JSON data, do
//
//     final filtersApiResponse = filtersApiResponseFromJson(jsonString);

import 'dart:convert';

FiltersApiResponse filtersApiResponseFromJson(String str) =>
    FiltersApiResponse.fromJson(json.decode(str));

String filtersApiResponseToJson(FiltersApiResponse data) =>
    json.encode(data.toJson());

class FiltersApiResponse {
  bool? success;
  String? message;
  FiltersData? data;

  FiltersApiResponse({this.success, this.message, this.data});

  factory FiltersApiResponse.fromJson(Map<String, dynamic> json) =>
      FiltersApiResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : FiltersData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class FiltersData {
  List<String>? brands;
  List<String>? sizes;
  List<String>? categories;
  List<String>? genders;
  Range? priceRange;
  Range? rentalPeriodRange;

  FiltersData({
    this.brands,
    this.sizes,
    this.categories,
    this.genders,
    this.priceRange,
    this.rentalPeriodRange,
  });

  factory FiltersData.fromJson(Map<String, dynamic> json) => FiltersData(
    brands: json["brands"] == null
        ? []
        : List<String>.from(json["brands"]!.map((x) => x)),
    sizes: json["sizes"] == null
        ? []
        : List<String>.from(json["sizes"]!.map((x) => x)),
    categories: json["categories"] == null
        ? []
        : List<String>.from(json["categories"]!.map((x) => x)),
    genders: json["genders"] == null
        ? []
        : List<String>.from(json["genders"]!.map((x) => x)),
    priceRange: json["price_range"] == null
        ? null
        : Range.fromJson(json["price_range"]),
    rentalPeriodRange: json["rental_period_range"] == null
        ? null
        : Range.fromJson(json["rental_period_range"]),
  );

  Map<String, dynamic> toJson() => {
    "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x)),
    "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x)),
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x)),
    "genders": genders == null ? [] : List<String>.from(genders!.map((x) => x)),
    "price_range": priceRange?.toJson(),
    "rental_period_range": rentalPeriodRange?.toJson(),
  };
}

class Range {
  var min;
  var max;

  Range({this.min, this.max});

  factory Range.fromJson(Map<String, dynamic> json) =>
      Range(min: json["min"], max: json["max"]);

  Map<String, dynamic> toJson() => {"min": min, "max": max};

  String getMinRental() {
    return (min ?? '').extractDays();
  }

  String getMaxRental() {
    return (max ?? '').extractDays();
  }
}
