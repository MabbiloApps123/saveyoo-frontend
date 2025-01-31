// To parse this JSON data, do
//
//     final storeDetailsResponse = storeDetailsResponseFromJson(jsonString);

import 'dart:convert';

StoreDetailsResponse storeDetailsResponseFromJson(String str) =>
    StoreDetailsResponse.fromJson(json.decode(str));

String storeDetailsResponseToJson(StoreDetailsResponse data) =>
    json.encode(data.toJson());

class StoreDetailsResponse {
  int statusCode;
  bool status;
  String message;
  List<Datum> data;

  StoreDetailsResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      StoreDetailsResponse(
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
  String originalPrice;
  String discountedPrice;
  String currency;
  String dealType;
  int quantity;
  String pickupStartTime;
  String pickupEndTime;
  bool isSurprise;
  Store store;
  String name;
  String productImage;
  String description;
  String category;

  Datum({
    required this.id,
    required this.originalPrice,
    required this.discountedPrice,
    required this.currency,
    required this.dealType,
    required this.quantity,
    required this.pickupStartTime,
    required this.pickupEndTime,
    required this.isSurprise,
    required this.store,
    required this.name,
    required this.productImage,
    required this.description,
    required this.category,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        name: json["name"],
        productImage: json["product_image"],
        description: json["description"],
        category: json["category"],
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
        "store": store.toJson(),
        "name": name,
        "product_image": productImage,
        "description": description,
        "category": category,
      };
}

class Store {
  int id;
  String name;
  String about;
  String webUrl;
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
  dynamic businessStartDate;
  dynamic gstNo;
  String latitude;
  String longitude;
  String vat;

  Store({
    required this.id,
    required this.name,
    required this.about,
    required this.webUrl,
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
    required this.businessStartDate,
    required this.gstNo,
    required this.latitude,
    required this.longitude,
    required this.vat,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        about: json["about"],
        webUrl: json["web_url"],
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
        businessStartDate: json["business_start_date"],
        gstNo: json["gst_no"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        vat: json["VAT"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "about": about,
        "web_url": webUrl,
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
        "business_start_date": businessStartDate,
        "gst_no": gstNo,
        "latitude": latitude,
        "longitude": longitude,
        "VAT": vat,
      };
}
