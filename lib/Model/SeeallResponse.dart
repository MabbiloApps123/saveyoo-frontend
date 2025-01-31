// To parse this JSON data, do
//
//     final seeallResponse = seeallResponseFromJson(jsonString);

import 'dart:convert';

SeeallResponse seeallResponseFromJson(String str) =>
    SeeallResponse.fromJson(json.decode(str));

String seeallResponseToJson(SeeallResponse data) => json.encode(data.toJson());

class SeeallResponse {
  int statusCode;
  bool status;
  String message;
  List<Datum> data;

  SeeallResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory SeeallResponse.fromJson(Map<String, dynamic> json) => SeeallResponse(
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
  int storeProductId;
  int productId;
  int storeId;
  String originalPrice;
  String discountedPrice;
  String currency;
  int quantity;
  String pickupStartTime;
  String pickupEndTime;
  String product;
  String productImage;
  bool isFavourite;
  int distance;
  double ratings;
  Store store;

  Datum({
    required this.storeProductId,
    required this.productId,
    required this.storeId,
    required this.originalPrice,
    required this.discountedPrice,
    required this.currency,
    required this.quantity,
    required this.pickupStartTime,
    required this.pickupEndTime,
    required this.product,
    required this.productImage,
    required this.isFavourite,
    required this.distance,
    required this.ratings,
    required this.store,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        storeProductId: json["store_product_id"],
        productId: json["product_id"],
        storeId: json["store_id"],
        originalPrice: json["original_price"],
        discountedPrice: json["discounted_price"],
        currency: json["currency"],
        quantity: json["quantity"],
        pickupStartTime: json["pickup_start_time"],
        pickupEndTime: json["pickup_end_time"],
        product: json["product"],
        productImage: json["product_image"],
        isFavourite: json["is_favourite"],
        distance: json["distance"],
        ratings: json["ratings"]?.toDouble(),
        store: Store.fromJson(json["store"]),
      );

  Map<String, dynamic> toJson() => {
        "store_product_id": storeProductId,
        "product_id": productId,
        "store_id": storeId,
        "original_price": originalPrice,
        "discounted_price": discountedPrice,
        "currency": currency,
        "quantity": quantity,
        "pickup_start_time": pickupStartTime,
        "pickup_end_time": pickupEndTime,
        "product": product,
        "product_image": productImage,
        "is_favourite": isFavourite,
        "distance": distance,
        "ratings": ratings,
        "store": store.toJson(),
      };
}

class Store {
  int id;
  String name;
  String imageUrl;
  String category;
  String openTime;
  String closeTime;

  Store({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.openTime,
    required this.closeTime,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        category: json["category"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "category": category,
        "open_time": openTime,
        "close_time": closeTime,
      };
}
