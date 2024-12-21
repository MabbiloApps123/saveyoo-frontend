// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/material.dart';
import 'package:saveyoo/Model/LoginResponse.dart';
import 'package:saveyoo/Model/LoginSuccessResponse.dart';
import 'package:saveyoo/Model/ResendOTPResponse.dart';
import 'package:saveyoo/Network/api_result_handler.dart';
import 'package:saveyoo/Repository/login_repo.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/screens.dart';
import 'package:saveyoo/Utils/utils.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:saveyoo/utils/pref_manager.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStatus> {
  final BuildContext mContext;
  StorageService storageService = StorageService();
  LoginBloc({
    required this.mContext,
  }) : super(LoginInitialState());

  void login({
    required String email,
    required String password,
  }) async {
    Loading(mLoaderGif).start(mContext);
    ApiResults apiResults =
        await LoginRepo().createLoginData(email, password, "");
    if (apiResults is ApiSuccess) {
      Loading.stop();
      handleLoginResponse(apiResults.data, apiResults.statusCode, email);
    } else if (apiResults is ApiFailure) {
      Loading.stop();
      ErrorToast(context: mContext, text: "Login details Error");
    }
  }

  Future<void> handleLoginResponse(json, int? statusCode, String email) async {
    if (LoginResponse.fromJson(json).statusCode == 200) {
      Navigator.pushReplacementNamed(
        mContext,
        loginsuccessRoute,
        arguments: [email],
      );
      SucessToast(
          context: mContext, text: LoginResponse.fromJson(json).message);
    } else {
      ErrorToast(context: mContext, text: LoginResponse.fromJson(json).message);
    }
  }

  void validateOTP({
    required String email,
    required String otp,
  }) async {
    Loading(mLoaderGif).start(mContext);
    ApiResults apiResults = await LoginRepo().validateOTP(email, otp, "");
    if (apiResults is ApiSuccess) {
      Loading.stop();
      handlevalidateOTPResponse(apiResults.data, apiResults.statusCode, email);
    } else if (apiResults is ApiFailure) {
      Loading.stop();
      ErrorToast(context: mContext, text: "Login details Error");
    }
  }

  Future<void> handlevalidateOTPResponse(
      json, int? statusCode, String email) async {
    if (LoginSuccessResponse.fromJson(json).statusCode == 200) {
      storageService.setBool(Constant.MLOGINSTATUS, true);

      storageService.setString(Constant.MUSEREMAIL,
          LoginSuccessResponse.fromJson(json).data.emailId);

      storageService.setString(Constant.MUSERID,
          LoginSuccessResponse.fromJson(json).data.id.toString());

      storageService.setString(Constant.MUSERACCESSTOKEN,
          LoginSuccessResponse.fromJson(json).data.accessToken);

      Navigator.pushReplacementNamed(mContext, setlocationRoute);
    } else {
      ErrorToast(context: mContext, text: LoginResponse.fromJson(json).message);
    }
  }

  void resendOTP({
    required String email,
  }) async {
    Loading(mLoaderGif).start(mContext);
    ApiResults apiResults = await LoginRepo().resendOTP(email);
    if (apiResults is ApiSuccess) {
      Loading.stop();
      handleresendOTPResponse(apiResults.data, apiResults.statusCode, email);
    } else if (apiResults is ApiFailure) {
      Loading.stop();
      ErrorToast(context: mContext, text: "Login details Error");
    }
  }

  Future<void> handleresendOTPResponse(
      json, int? statusCode, String email) async {
    if (ResendOtpResponse.fromJson(json).statusCode == 200) {
      SucessToast(
          context: mContext, text: ResendOtpResponse.fromJson(json).message);
    } else {
      ErrorToast(
          context: mContext, text: ResendOtpResponse.fromJson(json).message);
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
