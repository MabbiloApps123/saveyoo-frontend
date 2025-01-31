// To parse this JSON data, do
//
//     final homePageResponse = homePageResponseFromJson(jsonString);

import 'dart:convert';

HomePageResponse homePageResponseFromJson(String str) =>
    HomePageResponse.fromJson(json.decode(str));

String homePageResponseToJson(HomePageResponse data) =>
    json.encode(data.toJson());

class HomePageResponse {
  int statusCode;
  bool status;
  String message;
  Data data;

  HomePageResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomePageResponse.fromJson(Map<String, dynamic> json) =>
      HomePageResponse(
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
  List<AvailableNow>? justForYou;
  List<AvailableNow>? lastChanceDeals;
  List<AvailableNow>? availableNow;
  List<AvailableNow>? dinnertimeDeals;
  List<Supermarket>? supermarkets;

  Data({
    this.justForYou,
    this.lastChanceDeals,
    this.availableNow,
    this.dinnertimeDeals,
    this.supermarkets,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        justForYou: List<AvailableNow>.from(
            json["just_for_you"].map((x) => AvailableNow.fromJson(x))),
        lastChanceDeals: List<AvailableNow>.from(
            json["last_chance_deals"].map((x) => AvailableNow.fromJson(x))),
        availableNow: List<AvailableNow>.from(
            json["available_now"].map((x) => AvailableNow.fromJson(x))),
        dinnertimeDeals: List<AvailableNow>.from(
            json["dinnertime_deals"].map((x) => AvailableNow.fromJson(x))),
        supermarkets: List<Supermarket>.from(
            json["supermarkets"].map((x) => Supermarket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "just_for_you": List<dynamic>.from(justForYou!.map((x) => x)),
        "last_chance_deals":
            List<dynamic>.from(lastChanceDeals!.map((x) => x.toJson())),
        "available_now":
            List<dynamic>.from(availableNow!.map((x) => x.toJson())),
        "dinnertime_deals":
            List<dynamic>.from(dinnertimeDeals!.map((x) => x.toJson())),
        "supermarkets":
            List<dynamic>.from(supermarkets!.map((x) => x.toJson())),
      };
}

class AvailableNow {
  int? storeProductId;
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

  AvailableNow({
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

  factory AvailableNow.fromJson(Map<String, dynamic> json) => AvailableNow(
        storeProductId: json["store_product_id"] ?? 0,
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

class Supermarket {
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

  Supermarket({
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
  });

  factory Supermarket.fromJson(Map<String, dynamic> json) => Supermarket(
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
      };
}
