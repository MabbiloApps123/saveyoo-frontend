// To parse this JSON data, do
//
//     final favouriteResponse = favouriteResponseFromJson(jsonString);

import 'dart:convert';

FavouriteResponse favouriteResponseFromJson(String str) =>
    FavouriteResponse.fromJson(json.decode(str));

String favouriteResponseToJson(FavouriteResponse data) =>
    json.encode(data.toJson());

class FavouriteResponse {
  int statusCode;
  bool status;
  String message;
  Data data;

  FavouriteResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory FavouriteResponse.fromJson(Map<String, dynamic> json) =>
      FavouriteResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  StoreProduct storeProduct;
  int userId;
  bool isActive;
  int id;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Data({
    required this.storeProduct,
    required this.userId,
    required this.isActive,
    required this.id,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        storeProduct: StoreProduct.fromJson(json["store_product"]),
        userId: json["user_id"],
        isActive: json["is_active"],
        id: json["id"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "store_product": storeProduct.toJson(),
        "user_id": userId,
        "is_active": isActive,
        "id": id,
        "is_deleted": isDeleted,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class StoreProduct {
  int id;
  bool isActive;
  String originalPrice;
  String discountedPrice;
  String currency;
  String dealType;
  int quantity;
  DateTime pickupStartTime;
  DateTime pickupEndTime;
  bool isSurprise;
  Product product;

  StoreProduct({
    required this.id,
    required this.isActive,
    required this.originalPrice,
    required this.discountedPrice,
    required this.currency,
    required this.dealType,
    required this.quantity,
    required this.pickupStartTime,
    required this.pickupEndTime,
    required this.isSurprise,
    required this.product,
  });

  factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
        id: json["id"],
        isActive: json["is_active"],
        originalPrice: json["original_price"],
        discountedPrice: json["discounted_price"],
        currency: json["currency"],
        dealType: json["deal_type"],
        quantity: json["quantity"],
        pickupStartTime: DateTime.parse(json["pickup_start_time"]),
        pickupEndTime: DateTime.parse(json["pickup_end_time"]),
        isSurprise: json["is_surprise"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "original_price": originalPrice,
        "discounted_price": discountedPrice,
        "currency": currency,
        "deal_type": dealType,
        "quantity": quantity,
        "pickup_start_time": pickupStartTime.toIso8601String(),
        "pickup_end_time": pickupEndTime.toIso8601String(),
        "is_surprise": isSurprise,
        "product": product.toJson(),
      };
}

class Product {
  int id;
  bool isActive;
  String name;
  String productImage;
  String description;
  String category;
  String currency;

  Product({
    required this.id,
    required this.isActive,
    required this.name,
    required this.productImage,
    required this.description,
    required this.category,
    required this.currency,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        isActive: json["is_active"],
        name: json["name"],
        productImage: json["product_image"],
        description: json["description"],
        category: json["category"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "name": name,
        "product_image": productImage,
        "description": description,
        "category": category,
        "currency": currency,
      };
}
