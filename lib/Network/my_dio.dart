import 'dart:io';

import 'package:dio/dio.dart';
import 'package:saveyoo/Network/endpoints.dart';
import 'package:saveyoo/Utils/constant_methods.dart';

import 'api_result_handler.dart';

class MyDio {
  late Dio dio;

  MyDio() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      // connectTimeout: 3000,
      //receiveTimeout: 30 * 1000,
    );
    dio = Dio(baseOptions);
    printTest('dio');
  }

  Future<ApiResults> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    // dio.options.headers = {
    //   "Content-Type": "application/json",
    //   "Authorization": mToken,
    //   // "Access-Control-Allow-Origin": "*",
    // };

    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": mToken,
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
      // "Access-Control-Allow-Headers":
      //     "Origin, X-Requested-With, Content-Type, Accept",
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
    try {
      var response = await dio.get(endPoint, queryParameters: queryParameters);

      printResponse(response.statusCode.toString());
      printResponse('base:    ${dio.options.baseUrl}');
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('queryParameters:    $queryParameters');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("Error");
    } on FormatException {
      return ApiFailure("Error");
    } on DioException {
      return ApiFailure("Error");
    } catch (e) {
      return ApiFailure("Error");
    }
  }

  Future<ApiResults> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool formData = true,
    String? token,
  }) async {
    /* dio.options.headers["Access-Control-Allow-Credentials"] = "true";
    dio.options.headers["Access-Control-Allow-Headers"] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    dio.options.headers["Access-Control-Allow-Methods"] =
        "GET, HEAD, POST, OPTIONS";
    dio.options.headers["Access-Control-Allow-Methods"] =
        "GET, HEAD, POST, OPTIONS";*/

    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": mToken,
      "Access-Control-Allow-Origin": "*",
      "content-type": "multipart/form-data",
      "Access-Control-Allow-Headers": "Content-Type",
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale,pre-flight",
      "Access-Control-Allow-Methods": "POST, OPTIONS,GET, HEAD",

      /*{Accept: application/json, Authorization: token f3d40080905efdd:a9969f40877e947,
    Access-Control-Allow-Origin: *,
    content-type: multipart/form-data; boundary=--dio-boundary-3942469326}*/
    };

    try {
      var response = await dio.post(
        endPoint,
        data: formData ? FormData.fromMap(data ?? {}) : data,
        queryParameters: queryParameters,
      );

      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      printResponse('body:    $data');
      printResponse('response:    $response');
      return ApiSuccess(response.data, response.statusCode);
    } on SocketException {
      return ApiFailure("Error");
    } on FormatException {
      return ApiFailure("Error");
    } on DioException catch (e) {
      printResponse('url:    $endPoint');
      printResponse('header:    ${dio.options.headers}');
      //printResponse('body:    $data');
      print('body:    $data');
      print(e.error.toString());
      print(e.message);
      return ApiFailure(e.message ?? "Server API Error");
      return ApiFailure("Error");
    } catch (e) {
      return ApiFailure("$e Error ");
    }
  }
}
