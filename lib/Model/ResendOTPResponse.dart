// To parse this JSON data, do
//
//     final resendOtpResponse = resendOtpResponseFromJson(jsonString);

import 'dart:convert';

ResendOtpResponse resendOtpResponseFromJson(String str) =>
    ResendOtpResponse.fromJson(json.decode(str));

String resendOtpResponseToJson(ResendOtpResponse data) =>
    json.encode(data.toJson());

class ResendOtpResponse {
  int statusCode;
  bool status;
  String message;

  ResendOtpResponse({
    required this.statusCode,
    required this.status,
    required this.message,
  });

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) =>
      ResendOtpResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
      };
}
