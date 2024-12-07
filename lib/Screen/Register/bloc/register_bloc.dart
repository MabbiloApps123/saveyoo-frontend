import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:saveyoo/Screen/Register/bloc/register_event.dart';
import 'package:saveyoo/Screen/Register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterStatus> {
  final BuildContext mContext;

  RegisterBloc({
    required this.mContext,
  }) : super(RegisterInitialState());

  String mpassword = "";

  // void register({
  //   required String firstname,
  //   required String userid,
  //   required String phoneno,
  //   required String password,
  //   required String usertype,
  //   required String logintype,
  //   required String companyname,
  //   required String linkedin,
  // }) async {
  //   Loading(mLoaderGif).start(mContext);
  //   ApiResults apiResults = await RegisterRepo().createRegisterData(firstname,
  //       userid, phoneno, password, usertype, logintype, companyname, linkedin);
  //   if (apiResults is ApiSuccess) {
  //     Loading.stop();
  //     //  handleLoginResponse(apiResults.data, apiResults.statusCode);
  //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //     await prefs.setString(StorageServiceConstant.MUSERNAME, firstname);
  //     await prefs.setString(StorageServiceConstant.MUSEREMAIL, userid);
  //     await prefs.setString(StorageServiceConstant.MUSEREIMAGE, "");
  //     await prefs.setString(StorageServiceConstant.MUSEREMOBILE, phoneno);
  //
  //     /*sl<StorageService>()
  //         .setString(StorageServiceConstant.MUSERNAME, firstname);
  //
  //     sl<StorageService>().setString(StorageServiceConstant.MUSEREMAIL, userid);
  //
  //     sl<StorageService>().setString(StorageServiceConstant.MUSEREIMAGE, "");
  //
  //     sl<StorageService>()
  //         .setString(StorageServiceConstant.MUSEREMOBILE, phoneno);*/
  //
  //     Navigator.pushReplacementNamed(mContext, dashboardRoute);
  //
  //     SucessToast(
  //         context: mContext,
  //         text: CommonResponse.fromJson(apiResults.data).message!.message!);
  //   } else if (apiResults is ApiFailure) {
  //     Loading.stop();
  //     ErrorToast(context: mContext, text: "Failure");
  //   }
  // }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
