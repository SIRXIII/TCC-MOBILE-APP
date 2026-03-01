class Address {
  int? id;
  String? type;
  String? name;
  String? address;
  String? country;
  String? latitude;
  String? longitude;
  String? phone;
  String? createdAt;
  String? updatedAt;

  Address({
    this.id,
    this.type,
    this.name,
    this.address,
    this.country,
    this.latitude,
    this.longitude,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    address: json["address"],
    country: json["country"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    phone: json["phone"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "address": address,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
    "phone": phone,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  String getType() {
    return type ?? '';
  }

  int getId() {
    return id ?? 0;
  }

  String getName() {
    return name ?? '';
  }

  String getAddress() {
    return address ?? '';
  }

  String getCountry() {
    return country ?? '';
  }

  String getLatitude() {
    return latitude ?? '';
  }

  String getLongitude() {
    return longitude ?? '';
  }

  String getPhone() {
    return phone ?? '';
  }

  String getCreatedAt() => createdAt ?? '';

  String getUpdatedAt() => updatedAt ?? '';
}
