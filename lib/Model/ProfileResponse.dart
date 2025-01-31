// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  int statusCode;
  bool status;
  String message;
  ProfileData profiledata;

  ProfileResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.profiledata,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        profiledata: ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "data": profiledata.toJson(),
      };
}

class ProfileData {
  int? id;
  String? userName;
  String? profileUrl;
  String? emailId;
  String? mobileNo;
  bool? emailVerified;
  String? gender;
  String? userType;
  String? dob;
  String? lastLogin;
  String? deviceToken;
  bool? isBlocked;

  ProfileData({
    this.id,
    this.userName,
    this.profileUrl,
    this.emailId,
    this.mobileNo,
    this.emailVerified,
    this.gender,
    this.userType,
    this.dob,
    this.lastLogin,
    this.deviceToken,
    this.isBlocked,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        userName: json["user_name"],
        profileUrl: json["profile_url"],
        emailId: json["email_id"],
        mobileNo: json["mobile_no"],
        emailVerified: json["email_verified"],
        gender: json["gender"],
        userType: json["user_type"],
        dob: json["dob"],
        lastLogin: json["last_login"],
        deviceToken: json["device_token"],
        isBlocked: json["is_blocked"],
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
      };
}
