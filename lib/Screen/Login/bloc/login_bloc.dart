// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:saveyoo/Utils/screens.dart';
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
    // Loading(mLoaderGif).start(mContext);
    // ApiResults apiResults = await LoginRepo().createLoginData(email, password);
    // if (apiResults is ApiSuccess) {
    //   Loading.stop();
    //   handleLoginResponse(apiResults.data, apiResults.statusCode);
    // } else if (apiResults is ApiFailure) {
    //   Loading.stop();
    //   ErrorToast(context: mContext, text: "Login details Error");
    // }
    handleLoginResponse(num, 0);
  }

  //
  Future<void> handleLoginResponse(json, int? statusCode) async {
    storageService.setBool(Constant.MLOGINSTATUS, true);
    Navigator.pushReplacementNamed(mContext, setlocationRoute);

    // if (LoginResponse.fromJson(json).message!.status == true) {
    //   sl<StorageService>().setBool(Constant.MLOGINSTATUS, true);
    //   sl<StorageService>().setString(Constant.MUSERNAME,
    //       LoginResponse.fromJson(json).message!.userinfo!.fullName!);
    //   sl<StorageService>().setString(Constant.MUSEREMAIL,
    //       LoginResponse.fromJson(json).message!.userinfo!.userEmail!);
    //   sl<StorageService>().setString(Constant.MUSEREIMAGE,
    //       LoginResponse.fromJson(json).message!.userinfo!.image!);
    //   sl<StorageService>().setString(Constant.MEMPID,
    //       LoginResponse.fromJson(json).message!.userinfo!.empid!);
    //
    //   SucessToast(
    //       context: mContext,
    //       text: LoginResponse.fromJson(json).message!.message!);
    //
    //   Navigator.pushReplacementNamed(mContext, dashboardRoute);
    // }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
