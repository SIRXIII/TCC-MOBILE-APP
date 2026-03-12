// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'package:travel_clothing_club_flutter/app_modules/1_traveler/orders/models/partner.dart';
import 'package:travel_clothing_club_flutter/utils/app_imports.dart';
import 'package:travel_clothing_club_flutter/utils/extensions/string+ext.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int? id;
  String? productId;
  Partner? partner;
  String? name;
  String? brand;
  String? color;
  List<Size>? sizes;
  String? type;
  String? category;
  dynamic gender;
  String? material;
  String? careMethod;
  String? weight;
  String? sku;
  int? stock;
  String? basePrice;
  String? deposit;
  String? lateFee;
  String? replacementValue;
  String? buyPrice;
  dynamic extensions;
  String? prepBuffer;
  String? minRental;
  String? maxRental;
  dynamic blackoutDate;
  String? location;
  String? fitCategory;
  String? lengthUnit;
  String? length;
  String? chest;
  String? sleeve;
  String? conditionGrade;
  String? status;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? primaryImage;
  List<Image>? images;
  List<dynamic>? videos;
  dynamic rentalStats;
  String? verificationStatus;
  int? rating_count;
  int? average_rating;

  Product({
    this.id,
    this.productId,
    this.partner,
    this.name,
    this.brand,
    this.color,
    this.sizes,
    this.type,
    this.category,
    this.gender,
    this.material,
    this.careMethod,
    this.weight,
    this.sku,
    this.stock,
    this.basePrice,
    this.deposit,
    this.lateFee,
    this.replacementValue,
    this.buyPrice,
    this.extensions,
    this.prepBuffer,
    this.minRental,
    this.maxRental,
    this.blackoutDate,
    this.location,
    this.fitCategory,
    this.lengthUnit,
    this.length,
    this.chest,
    this.sleeve,
    this.conditionGrade,
    this.status,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.primaryImage,
    this.images,
    this.videos,
    this.rentalStats,
    this.verificationStatus,
    this.rating_count,
    this.average_rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productId: json["product_id"],
    partner: json["partner"] == null ? null : Partner.fromJson(json["partner"]),
    name: json["name"],
    brand: json["brand"],
    color: json["color"],
    sizes: json["sizes"] == null
        ? []
        : List<Size>.from(json["sizes"]!.map((x) => Size.fromJson(x))),
    type: json["type"],
    category: json["category"],
    gender: json["gender"],
    material: json["material"],
    careMethod: json["care_method"],
    weight: json["weight"],
    sku: json["sku"],
    stock: json["stock"],
    basePrice: json["base_price"],
    deposit: json["deposit"],
    lateFee: json["late_fee"],
    replacementValue: json["replacement_value"],
    buyPrice: json["buy_price"],
    extensions: json["extensions"],
    prepBuffer: json["prep_buffer"],
    minRental: json["min_rental"],
    maxRental: json["max_rental"],
    blackoutDate: json["blackout_date"],
    location: json["location"],
    fitCategory: json["fit_category"],
    lengthUnit: json["length_unit"],
    length: json["length"],
    chest: json["chest"],
    sleeve: json["sleeve"],
    conditionGrade: json["condition_grade"],
    status: json["status"],
    note: json["note"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    primaryImage: json["primary_image"],
    images: json["images"] == null
        ? []
        : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    videos: json["videos"] == null
        ? []
        : List<dynamic>.from(json["videos"]!.map((x) => x)),
    rentalStats: json["rental_stats"],
    verificationStatus: json["verification_status"],
    rating_count: json["rating_count"],
    average_rating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "partner": partner?.toJson(),
    "name": name,
    "brand": brand,
    "color": color,
    "sizes": sizes == null
        ? []
        : List<dynamic>.from(sizes!.map((x) => x.toJson())),
    "type": type,
    "category": category,
    "gender": gender,
    "material": material,
    "care_method": careMethod,
    "weight": weight,
    "sku": sku,
    "stock": stock,
    "base_price": basePrice,
    "deposit": deposit,
    "late_fee": lateFee,
    "replacement_value": replacementValue,
    "buy_price": buyPrice,
    "extensions": extensions,
    "prep_buffer": prepBuffer,
    "min_rental": minRental,
    "max_rental": maxRental,
    "blackout_date": blackoutDate,
    "location": location,
    "fit_category": fitCategory,
    "length_unit": lengthUnit,
    "length": length,
    "chest": chest,
    "sleeve": sleeve,
    "condition_grade": conditionGrade,
    "status": status,
    "note": note,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "primary_image": primaryImage,
    "images": images == null
        ? []
        : List<dynamic>.from(images!.map((x) => x.toJson())),
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
    "rental_stats": rentalStats,
    "verification_status": verificationStatus,
    "rating_count": rating_count,
    "average_rating": average_rating,
  };

  bool isStockAvailable() {
    if (stock == null || stock == 0) {
      return false;
    }
    return true;
  }

  int getStock() {
    return stock ?? 0;
  }

  double getPrice() {
    return double.parse(basePrice!);
  }

  String getName() {
    return name ?? '';
  }

  String getNote() {
    return note ?? '';
  }

  String getMinRental() {
    return (minRental ?? '').extractDays();
  }

  String getMaxRental() {
    return (maxRental ?? '').extractDays();
  }

  Color getColor() {
    return color?.toColor() ?? AppColors.TRANSPARENT;
  }
  // String getSize() {
  //   return size ?? '';
  // }

  String getOrderId() {
    return productId ?? '';
  }

  String getRating() {
    // debugPrint('getRating() called with rating: $rating');

    if (average_rating == null || average_rating == 0) {
      return '';
    }
    return average_rating.toString();
  }

  String getRatingCount() {
    // debugPrint('getRating() called with rating: $rating');

    if (rating_count == null) {
      return '';
    }
    return rating_count.toString();
  }

  // List<Color> getColorList() {
  //   if (color == null || color == '') {
  //     return [AppColors.TRANSPARENT];
  //   }
  //   return color!
  //       .split(',')
  //       .map((c) => _mapColorNameToColor(c.trim().toLowerCase()))
  //       .whereType<Color>()
  //       .toList();
  // }

  List<ProductColor> get productColors {
    if (color == null || color == '' || color!.contains('#')) {
      return [];
    }

    return color!
        .split(',')
        .map((c) {
          final name = c.trim();
          final color = _mapColorByName(name.toLowerCase());
          if (color != null) {
            return ProductColor(name: name, color: color);
          }
          return null;
        })
        .whereType<ProductColor>()
        .toList();
  }

  Color? _mapColorByName(String? name) {
    if (name == null || name.trim().isEmpty) return null;

    final key = name.toLowerCase().trim();

    const Map<String, Color> colorMap = {
      // Primary
      'red': Colors.red,
      'blue': Colors.blue,
      'green': Colors.green,
      'yellow': Colors.yellow,

      // Neutrals
      'black': Colors.black,
      'white': Colors.white,
      'grey': Colors.grey,
      'gray': Colors.grey,
      'brown': Colors.brown,

      // Metallic / special
      'gold': Color(0xFFFFD700),
      'silver': Color(0xFFC0C0C0),
      'bronze': Color(0xFFCD7F32),

      // Extended colors
      'orange': Colors.orange,
      'purple': Colors.purple,
      'pink': Colors.pink,
      'cyan': Colors.cyan,
      'teal': Colors.teal,
      'lime': Colors.lime,
      'amber': Colors.amber,
      'indigo': Colors.indigo,
      'deep purple': Colors.deepPurple,
      'deep orange': Colors.deepOrange,

      // Light variants
      'light red': Colors.redAccent,
      'light blue': Colors.lightBlue,
      'light green': Colors.lightGreen,
      'light yellow': Colors.yellowAccent,
      'light pink': Colors.pinkAccent,
      'light grey': Colors.grey,
      'light gray': Colors.grey,

      // Dark variants
      'dark red': Color(0xFF8B0000),
      'dark blue': Color(0xFF00008B),
      'dark green': Color(0xFF006400),
      'dark yellow': Color(0xFF9B870C),
      'dark orange': Color(0xFFFF8C00),
      'dark purple': Color(0xFF4B0082),
      'dark brown': Color(0xFF5D4037),
      'dark grey': Color(0xFF616161),
      'dark gray': Color(0xFF616161),
      'sky blue': Color(0xFF87CEEB),

      // Common UI colors
      'transparent': Colors.transparent,
      'clear': Colors.transparent,
    };

    return colorMap[key];
  }
}

class ProductColor {
  final String name;
  final Color color;

  ProductColor({required this.name, required this.color});
}

class Size {
  int? id;
  String? size;
  int? quantity;

  Size({this.id, this.size, this.quantity});

  factory Size.fromJson(Map<String, dynamic> json) =>
      Size(id: json["id"], size: json["size"], quantity: json["quantity"]);

  Map<String, dynamic> toJson() => {
    "id": id,
    "size": size,
    "quantity": quantity,
  };

  String getSize() {
    return '$size';
    return '$size ${quantity ?? 0}';
  }

  bool isStockAvailable() {
    if (quantity == null || quantity == 0) {
      return false;
    }
    return true;
  }
}

class Image {
  int? id;
  int? productId;
  String? imageUrl;
  bool? isPrimary;
  int? sortOrder;
  DateTime? createdAt;

  Image({
    this.id,
    this.productId,
    this.imageUrl,
    this.isPrimary,
    this.sortOrder,
    this.createdAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    productId: json["product_id"],
    imageUrl: json["image_url"],
    isPrimary: json["is_primary"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "image_url": imageUrl,
    "is_primary": isPrimary,
    "sort_order": sortOrder,
    "created_at": createdAt?.toIso8601String(),
  };
}

// class Partner {
//   int? id;
//   String? profilePhoto;
//   String? businessName;
//   String? name;
//   String? email;
//   String? phone;
//   String? category;
//   dynamic location;
//   String? address;
//   String? username;
//   String? availability;
//   String? latitude;
//   String? longitude;
//   String? taxId;
//   String? status;
//   dynamic totalSales;
//   int? deliveredOrdersCount;
//   double? rating;
//   int? reviewsCount;
//   List<Complaint>? commonComplaints;
//   Complaint? latestComplaint;
//   String? createdAt;
//   DateTime? updatedAt;
//   String? type;
//   Documents? documents;
//
//   Partner({
//     this.id,
//     this.profilePhoto,
//     this.businessName,
//     this.name,
//     this.email,
//     this.phone,
//     this.category,
//     this.location,
//     this.address,
//     this.username,
//     this.availability,
//     this.latitude,
//     this.longitude,
//     this.taxId,
//     this.status,
//     this.totalSales,
//     this.deliveredOrdersCount,
//     this.rating,
//     this.reviewsCount,
//     this.commonComplaints,
//     this.latestComplaint,
//     this.createdAt,
//     this.updatedAt,
//     this.type,
//     this.documents,
//   });
//
//   factory Partner.fromJson(Map<String, dynamic> json) => Partner(
//     id: json["id"],
//     profilePhoto: json["profile_photo"],
//     businessName: json["business_name"],
//     name: json["name"],
//     email: json["email"],
//     phone: json["phone"],
//     category: json["category"],
//     location: json["location"],
//     address: json["address"],
//     username: json["username"],
//     availability: json["availability"],
//     latitude: json["latitude"],
//     longitude: json["longitude"],
//     taxId: json["tax_id"],
//     status: json["status"],
//     totalSales: json["total_sales"],
//     deliveredOrdersCount: json["delivered_orders_count"],
//     rating: json["rating"]?.toDouble(),
//     reviewsCount: json["reviews_count"],
//     commonComplaints: json["common_complaints"] == null
//         ? []
//         : List<Complaint>.from(
//             json["common_complaints"]!.map((x) => Complaint.fromJson(x)),
//           ),
//     latestComplaint: json["latest_complaint"] == null
//         ? null
//         : Complaint.fromJson(json["latest_complaint"]),
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"] == null
//         ? null
//         : DateTime.parse(json["updated_at"]),
//     type: json["type"],
//     documents: json["documents"] == null
//         ? null
//         : Documents.fromJson(json["documents"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "profile_photo": profilePhoto,
//     "business_name": businessName,
//     "name": name,
//     "email": email,
//     "phone": phone,
//     "category": category,
//     "location": location,
//     "address": address,
//     "username": username,
//     "availability": availability,
//     "latitude": latitude,
//     "longitude": longitude,
//     "tax_id": taxId,
//     "status": status,
//     "total_sales": totalSales,
//     "delivered_orders_count": deliveredOrdersCount,
//     "rating": rating,
//     "reviews_count": reviewsCount,
//     "common_complaints": commonComplaints == null
//         ? []
//         : List<dynamic>.from(commonComplaints!.map((x) => x.toJson())),
//     "latest_complaint": latestComplaint?.toJson(),
//     "created_at": createdAt,
//     "updated_at": updatedAt?.toIso8601String(),
//     "type": type,
//     "documents": documents?.toJson(),
//   };
//
//   String getProfileImage() {
//     return profilePhoto ?? '';
//   }
//
//   String getName() {
//     return name ?? '';
//   }
//
//   String getRating() {
//     return rating.toString() ?? '';
//   }
//
//   int getPartnerId() {
//     return id ?? 0;
//   }
// }
//
// class Complaint {
//   int? id;
//   String? message;
//   DateTime? createdAt;
//
//   Complaint({this.id, this.message, this.createdAt});
//
//   factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
//     id: json["id"],
//     message: json["message"],
//     createdAt: json["created_at"] == null
//         ? null
//         : DateTime.parse(json["created_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "message": message,
//     "created_at": createdAt?.toIso8601String(),
//   };
// }
//
// class Documents {
//   List<dynamic>? license;
//   List<dynamic>? ownerIdCard;
//
//   Documents({this.license, this.ownerIdCard});
//
//   factory Documents.fromJson(Map<String, dynamic> json) => Documents(
//     license: json["license"] == null
//         ? []
//         : List<dynamic>.from(json["license"]!.map((x) => x)),
//     ownerIdCard: json["owner_id_card"] == null
//         ? []
//         : List<dynamic>.from(json["owner_id_card"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "license": license == null
//         ? []
//         : List<dynamic>.from(license!.map((x) => x)),
//     "owner_id_card": ownerIdCard == null
//         ? []
//         : List<dynamic>.from(ownerIdCard!.map((x) => x)),
//   };
// }
