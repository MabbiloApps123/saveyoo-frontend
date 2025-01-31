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
        .postData(endPoint: resendOTPAPI, data: {'email': email});
  }

  Future<ApiResults> logout(
    String userid,
  ) async {
    return await sl<MyDio>()
        .postData(endPoint: logoutAPI, data: {'user_id': userid});
  }

  Future<ApiResults> getHome(
      String latitude, String longitude, String radius) async {
    return await sl<MyDio>().getData(endPoint: homeAPI, queryParameters: {
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
    });
  }

  Future<ApiResults> getSellAll(
      String latitude, String longitude, String radius, String category) async {
    return await sl<MyDio>().getData(endPoint: viewAllAPI, queryParameters: {
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'category': category,
    });
  }

  Future<ApiResults> getProfileData(
    String userId,
  ) async {
    return await sl<MyDio>()
        .getProfileData(endPoint: profileAPI, userId: userId);
  }

  Future<ApiResults> updateProfileData(
    int id,
    String username,
    String email,
    String mobileno,
    bool emailverified,
    String dob,
    String profileurl,
    String password,
    String devicetoken,
    String gender,
  ) async {
    return await sl<MyDio>().postData(endPoint: profileUpdateAPI, data: {
      'id': id,
      'user_name': username,
      'email_id': email,
      'mobile_no': "+91$mobileno",
      'email_verified': emailverified,
      'dob': dob,
      'profile_url': profileurl,
      //'password': password,
      'device_token': devicetoken,
      'gender': gender
    });
  }

  Future<ApiResults> getStoreAll(
      String latitude, String longitude, String radius, String category) async {
    return await sl<MyDio>()
        .getData(endPoint: StoreviewAllAPI, queryParameters: {
      'category': category,
    });
  }

  Future<ApiResults> getStoreProductbyId(
    String userId,
  ) async {
    return await sl<MyDio>()
        .getProfileData(endPoint: getStoreProductAPI, userId: userId);
  }

  Future<ApiResults> getStoreDetailsbyId(
    String StoreId,
  ) async {
    return await sl<MyDio>()
        .getProfileData(endPoint: getStoreDetailsAPI, userId: StoreId);
  }

  Future<ApiResults> changefavourite(
      String storeproductid, String userid, bool isactive) async {
    return await sl<MyDio>()
        .getData(endPoint: changefavouriteAPI, queryParameters: {
      'store_product_id': storeproductid,
      'user_id': userid,
      'is_active': isactive,
    });
  }

  Future<ApiResults> getfavourite(String userid) async {
    return await sl<MyDio>()
        .getData(endPoint: getfavouriteAPI, queryParameters: {
      'user_id': userid,
    });
  }
}
