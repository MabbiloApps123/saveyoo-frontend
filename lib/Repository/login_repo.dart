import 'package:saveyoo/Network/api_result_handler.dart';
import 'package:saveyoo/Network/di.dart';
import 'package:saveyoo/Network/endpoints.dart';
import 'package:saveyoo/Network/my_dio.dart';

class LoginRepo {
  Future<ApiResults> createLoginData(
    String email,
    String password,
    String devicetoken,
  ) async {
    return await sl<MyDio>().postData(endPoint: loginAPI, data: {
      'email_id': email,
      'password': password,
      'device_token': devicetoken
    });
  }

  Future<ApiResults> validateOTP(
    String email,
    String otp,
    String devicetoken,
  ) async {
    return await sl<MyDio>().postData(
        endPoint: validateOTPAPI,
        data: {'email_id': email, 'otp': otp, 'device_token': devicetoken});
  }

  Future<ApiResults> resendOTP(
    String email,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: resendOTPAPI, data: {'email_id': email});
  }

  Future<ApiResults> logout(
    String userid,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: logoutAPI, data: {'user_id': userid});
  }
}
