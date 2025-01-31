// To parse this JSON data, do
//
//     final getFavouriteResponse = getFavouriteResponseFromJson(jsonString);

import 'dart:convert';

GetFavouriteResponse getFavouriteResponseFromJson(String str) =>
    GetFavouriteResponse.fromJson(json.decode(str));

String getFavouriteResponseToJson(GetFavouriteResponse data) =>
    json.encode(data.toJson());

class GetFavouriteResponse {
  int statusCode;
  bool status;
  String message;
  List<Datum> data;

  GetFavouriteResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetFavouriteResponse.fromJson(Map<String, dynamic> json) =>
      GetFavouriteResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  bool isActive;
  int userId;
  StoreProduct storeProduct;

  Datum({
    required this.id,
    required this.isActive,
    required this.userId,
    required this.storeProduct,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        isActive: json["is_active"],
        userId: json["user_id"],
        storeProduct: StoreProduct.fromJson(json["store_product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "user_id": userId,
        "store_product": storeProduct.toJson(),
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
  String pickupStartTime;
  String pickupEndTime;
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
        pickupStartTime: json["pickup_start_time"],
        pickupEndTime: json["pickup_end_time"],
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
        "pickup_start_time": pickupStartTime,
        "pickup_end_time": pickupEndTime,
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
