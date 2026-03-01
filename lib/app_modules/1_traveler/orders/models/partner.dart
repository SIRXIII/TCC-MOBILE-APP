
class Partner {
  int? id;
  String? profilePhoto;
  String? businessName;
  String? name;
  String? email;
  String? phone;
  String? category;
  dynamic location;
  String? address;
  String? username;
  dynamic availability;
  String? latitude;
  String? longitude;
  String? taxId;
  String? status;
  dynamic totalSales;
  int? deliveredOrdersCount;
  dynamic rating;
  int? reviewsCount;
  List<Complaint>? commonComplaints;
  Complaint? latestComplaint;
  String? createdAt;
  DateTime? updatedAt;
  String? type;
  PartnerDocuments? documents;

  Partner({
    this.id,
    this.profilePhoto,
    this.businessName,
    this.name,
    this.email,
    this.phone,
    this.category,
    this.location,
    this.address,
    this.username,
    this.availability,
    this.latitude,
    this.longitude,
    this.taxId,
    this.status,
    this.totalSales,
    this.deliveredOrdersCount,
    this.rating,
    this.reviewsCount,
    this.commonComplaints,
    this.latestComplaint,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.documents,
  });

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
    id: json["id"],
    profilePhoto: json["profile_photo"],
    businessName: json["business_name"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    category: json["category"],
    location: json["location"],
    address: json["address"],
    username: json["username"],
    availability: json["availability"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    taxId: json["tax_id"],
    status: json["status"],
    totalSales: json["total_sales"],
    deliveredOrdersCount: json["delivered_orders_count"],
    rating: json["rating"],
    reviewsCount: json["reviews_count"],
    commonComplaints: json["common_complaints"] == null
        ? []
        : List<Complaint>.from(
            json["common_complaints"]!.map((x) => Complaint.fromJson(x)),
          ),
    latestComplaint: json["latest_complaint"] == null
        ? null
        : Complaint.fromJson(json["latest_complaint"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    type: json["type"],
    documents: json["documents"] == null
        ? null
        : PartnerDocuments.fromJson(json["documents"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_photo": profilePhoto,
    "business_name": businessName,
    "name": name,
    "email": email,
    "phone": phone,
    "category": category,
    "location": location,
    "address": address,
    "username": username,
    "availability": availability,
    "latitude": latitude,
    "longitude": longitude,
    "tax_id": taxId,
    "status": status,
    "total_sales": totalSales,
    "delivered_orders_count": deliveredOrdersCount,
    "rating": rating,
    "reviews_count": reviewsCount,
    "common_complaints": commonComplaints == null
        ? []
        : List<dynamic>.from(commonComplaints!.map((x) => x.toJson())),
    "latest_complaint": latestComplaint?.toJson(),
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "type": type,
    "documents": documents?.toJson(),
  };

  String getId() {
    return id.toString() ?? '';
  }

  String getProfileImage() {
    return profilePhoto ?? '';
  }

  String getName() {
    return name ?? '';
  }

  String getAddress() {
    return address ?? 'N/A';
  }

  String getRating() {
    // debugPrint('getRating() called with rating: $rating');

    if (rating == null) {
      return '';
    }
    return rating.toString();
  }

  int getPartnerId() {
    return id ?? 0;
  }
}

class PartnerDocuments {
  List<dynamic>? license;
  List<dynamic>? ownerIdCard;

  PartnerDocuments({this.license, this.ownerIdCard});

  factory PartnerDocuments.fromJson(Map<String, dynamic> json) =>
      PartnerDocuments(
        license: json["license"] == null
            ? []
            : List<dynamic>.from(json["license"]!.map((x) => x)),
        ownerIdCard: json["owner_id_card"] == null
            ? []
            : List<dynamic>.from(json["owner_id_card"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "license": license == null
        ? []
        : List<dynamic>.from(license!.map((x) => x)),
    "owner_id_card": ownerIdCard == null
        ? []
        : List<dynamic>.from(ownerIdCard!.map((x) => x)),
  };
}

class Complaint {
  int? id;
  String? message;
  DateTime? createdAt;

  Complaint({this.id, this.message, this.createdAt});

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
    id: json["id"],
    message: json["message"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "created_at": createdAt?.toIso8601String(),
  };
}
