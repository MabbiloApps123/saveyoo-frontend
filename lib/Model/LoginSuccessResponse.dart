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
  bool isActive;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  dynamic userName;
  dynamic profileUrl;
  String emailId;
  dynamic mobileNo;
  bool emailVerified;
  dynamic gender;
  dynamic dob;
  dynamic lastLogin;
  dynamic deviceToken;
  bool isBlocked;
  String accessToken;

  Data({
    required this.id,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.userName,
    required this.profileUrl,
    required this.emailId,
    required this.mobileNo,
    required this.emailVerified,
    required this.gender,
    required this.dob,
    required this.lastLogin,
    required this.deviceToken,
    required this.isBlocked,
    required this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        userName: json["user_name"],
        profileUrl: json["profile_url"],
        emailId: json["email_id"],
        mobileNo: json["mobile_no"],
        emailVerified: json["email_verified"],
        gender: json["gender"],
        dob: json["dob"],
        lastLogin: json["last_login"],
        deviceToken: json["device_token"],
        isBlocked: json["is_blocked"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_active": isActive,
        "is_deleted": isDeleted,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "user_name": userName,
        "profile_url": profileUrl,
        "email_id": emailId,
        "mobile_no": mobileNo,
        "email_verified": emailVerified,
        "gender": gender,
        "dob": dob,
        "last_login": lastLogin,
        "device_token": deviceToken,
        "is_blocked": isBlocked,
        "access_token": accessToken,
      };
}
