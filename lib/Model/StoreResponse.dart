// To parse this JSON data, do
//
//     final storeResponse = storeResponseFromJson(jsonString);

import 'dart:convert';

StoreResponse storeResponseFromJson(String str) =>
    StoreResponse.fromJson(json.decode(str));

String storeResponseToJson(StoreResponse data) => json.encode(data.toJson());

class StoreResponse {
  int statusCode;
  bool status;
  String message;
  List<StoreResponseDatum> data;

  StoreResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) => StoreResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        data: List<StoreResponseDatum>.from(
            json["data"].map((x) => StoreResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StoreResponseDatum {
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

  StoreResponseDatum({
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

  factory StoreResponseDatum.fromJson(Map<String, dynamic> json) =>
      StoreResponseDatum(
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
