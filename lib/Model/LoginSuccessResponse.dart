// To parse this JSON data, do
//
//     final loginSuccessResponse = loginSuccessResponseFromJson(jsonString);

import 'dart:convert';

LoginSuccessResponse loginSuccessResponseFromJson(String str) =>
    LoginSuccessResponse.fromJson(json.decode(str));

String loginSuccessResponseToJson(LoginSuccessResponse data) =>
    json.encode(data.toJson());

class LoginSuccessResponse {
  int statusCode;
  bool status;
  String message;
  Data data;

  LoginSuccessResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginSuccessResponse.fromJson(Map<String, dynamic> json) =>
      LoginSuccessResponse(
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
  int id;
  String userName;
  String profileUrl;
  String emailId;
  String mobileNo;
  bool emailVerified;
  String gender;
  String userType;
  String dob;
  String lastLogin;
  String deviceToken;
  bool isBlocked;
  String accessToken;

  Data({
    required this.id,
    required this.userName,
    required this.profileUrl,
    required this.emailId,
    required this.mobileNo,
    required this.emailVerified,
    required this.gender,
    required this.userType,
    required this.dob,
    required this.lastLogin,
    required this.deviceToken,
    required this.isBlocked,
    required this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userName: json["user_name"] ?? "",
        profileUrl: json["profile_url"] ?? "",
        emailId: json["email_id"] ?? "",
        mobileNo: json["mobile_no"] ?? "",
        emailVerified: json["email_verified"] ?? "",
        gender: json["gender"] ?? "",
        userType: json["user_type"] ?? "",
        dob: json["dob"] ?? "",
        lastLogin: json["last_login"] ?? "",
        deviceToken: json["device_token"] ?? "",
        isBlocked: json["is_blocked"] ?? "",
        accessToken: json["access_token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "profile_url": profileUrl,
        "email_id": emailId,
        "mobile_no": mobileNo,
        "email_verified": emailVerified,
        "gender": gender,
        "user_type": userType,
        "dob": dob,
        "last_login": lastLogin,
        "device_token": deviceToken,
        "is_blocked": isBlocked,
        "access_token": accessToken,
      };
}
