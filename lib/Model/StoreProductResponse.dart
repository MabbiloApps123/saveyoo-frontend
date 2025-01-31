// To parse this JSON data, do
//
//     final storeProductResponse = storeProductResponseFromJson(jsonString);

import 'dart:convert';

StoreProductResponse storeProductResponseFromJson(String str) =>
    StoreProductResponse.fromJson(json.decode(str));

String storeProductResponseToJson(StoreProductResponse data) =>
    json.encode(data.toJson());

class StoreProductResponse {
  int statusCode;
  bool status;
  String message;
  StoreProductData data;

  StoreProductResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory StoreProductResponse.fromJson(Map<String, dynamic> json) =>
      StoreProductResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        data: StoreProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class StoreProductData {
  int? id;
  String? originalPrice;
  String? discountedPrice;
  String? currency;
  String? dealType;
  int? quantity;
  String? pickupStartTime;
  String? pickupEndTime;
  bool? isSurprise;
  Store? store;
  StoreProduct? product;

  StoreProductData({
    this.id,
    this.originalPrice,
    this.discountedPrice,
    this.currency,
    this.dealType,
    this.quantity,
    this.pickupStartTime,
    this.pickupEndTime,
    this.isSurprise,
    this.store,
    this.product,
  });

  factory StoreProductData.fromJson(Map<String, dynamic> json) =>
      StoreProductData(
        id: json["id"],
        originalPrice: json["original_price"],
        discountedPrice: json["discounted_price"],
        currency: json["currency"],
        dealType: json["deal_type"],
        quantity: json["quantity"],
        pickupStartTime: json["pickup_start_time"],
        pickupEndTime: json["pickup_end_time"],
        isSurprise: json["is_surprise"],
        store: Store.fromJson(json["store"]),
        product: StoreProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_price": originalPrice,
        "discounted_price": discountedPrice,
        "currency": currency,
        "deal_type": dealType,
        "quantity": quantity,
        "pickup_start_time": pickupStartTime,
        "pickup_end_time": pickupEndTime,
        "is_surprise": isSurprise,
        "store": store?.toJson(),
        "product": product?.toJson(),
      };
}

class StoreProduct {
  int id;
  String name;
  String productImage;
  String description;
  String category;
  String currency;

  StoreProduct({
    required this.id,
    required this.name,
    required this.productImage,
    required this.description,
    required this.category,
    required this.currency,
  });

  factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
        id: json["id"],
        name: json["name"],
        productImage: json["product_image"],
        description: json["description"],
        category: json["category"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_image": productImage,
        "description": description,
        "category": category,
        "currency": currency,
      };
}

class Store {
  int id;
  String name;
  String imageUrl;
  String mobileNo;
  String alternateMobileNo;
  String email;
  String street;
  String city;
  String state;
  String postalCode;
  String country;
  String category;
  String openTime;
  String closeTime;
  int ownerId;
  dynamic businessStartData;
  String latitude;
  String longitude;

  Store({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.mobileNo,
    required this.alternateMobileNo,
    required this.email,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.category,
    required this.openTime,
    required this.closeTime,
    required this.ownerId,
    required this.businessStartData,
    required this.latitude,
    required this.longitude,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        mobileNo: json["mobile_no"],
        alternateMobileNo: json["alternate_mobile_no"],
        email: json["email"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postal_code"],
        country: json["country"],
        category: json["category"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
        ownerId: json["owner_id"],
        businessStartData: json["business_start_data"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "mobile_no": mobileNo,
        "alternate_mobile_no": alternateMobileNo,
        "email": email,
        "street": street,
        "city": city,
        "state": state,
        "postal_code": postalCode,
        "country": country,
        "category": category,
        "open_time": openTime,
        "close_time": closeTime,
        "owner_id": ownerId,
        "business_start_data": businessStartData,
        "latitude": latitude,
        "longitude": longitude,
      };
}
