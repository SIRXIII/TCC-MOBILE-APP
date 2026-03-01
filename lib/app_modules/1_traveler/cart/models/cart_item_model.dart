// models/cart_item_model.dart
class CartItem {
  final int? id;
  final int productId;
  final int partnerId;
  final String productName;
  final String productDescription;
  final double productPrice;
  final String productImage;
  final String productBrand;
  final String size;
  final String color;
  final int rentalDays;
  int quantity;
  final DateTime addedAt;

  CartItem({
    this.id,
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.productBrand,
    required this.size,
    required this.color,
    required this.rentalDays,
    this.quantity = 1,
    required this.addedAt,
    required this.partnerId,
  });

  double get totalPrice => productPrice * quantity * rentalDays;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'productImage': productImage,
      'productBrand': productBrand,
      'size': size,
      'color': color,
      'rentalDays': rentalDays,
      'quantity': quantity,
      'addedAt': addedAt.millisecondsSinceEpoch,
      'partnerId': partnerId,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productId: map['productId'],
      productName: map['productName'],
      partnerId: map['partnerId'],
      productDescription: map['productDescription'],
      productPrice: map['productPrice'],
      productImage: map['productImage'],
      productBrand: map['productBrand'],
      size: map['size'],
      color: map['color'],
      rentalDays: map['rentalDays'],
      quantity: map['quantity'],
      addedAt: DateTime.fromMillisecondsSinceEpoch(map['addedAt']),
    );
  }

  CartItem copyWith({
    int? id,
    int? productId,
    int? partnerId,
    String? productName,
    String? productDescription,
    double? productPrice,
    String? productImage,
    String? productBrand,
    String? size,
    String? color,
    int? rentalDays,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      partnerId: partnerId ?? this.partnerId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productPrice: productPrice ?? this.productPrice,
      productImage: productImage ?? this.productImage,
      productBrand: productBrand ?? this.productBrand,
      size: size ?? this.size,
      color: color ?? this.size,
      rentalDays: rentalDays ?? this.rentalDays,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
