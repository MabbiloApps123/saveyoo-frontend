import 'package:custom_gif_loading/custom_gif_loading.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Model/ProfileResponse.dart';
import 'package:saveyoo/Network/api_result_handler.dart';
import 'package:saveyoo/Repository/login_repo.dart';
import 'package:saveyoo/Screen/Profile/bloc/profile_event.dart';
import 'package:saveyoo/Screen/Profile/bloc/profile_state.dart';
import 'package:saveyoo/Utils/constant_methods.dart';
import 'package:saveyoo/Utils/utils.dart';
import 'package:saveyoo/utils/constant.dart';

import '../../../utils/pref_manager.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  ProfileData mGetProfile = ProfileData();

  ProfileBloc({required this.mContext}) : super(ProfileInitialState()) {
    on<SetProfileScreen>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void getProfileInfo() async {
    String userId = await storageService.getString(Constant.MUSERID) ?? "1";
    ApiResults apiResults = await LoginRepo().getProfileData(userId);
    if (apiResults is ApiSuccess) {
      handleProfileResponse(apiResults.data);
    } else if (apiResults is ApiFailure) {
      emit(GetProfileInfoFailState());
    }
  }

  void handleProfileResponse(json) {
    mGetProfile = ProfileResponse.fromJson(json).profiledata!;

    emit(GetProfileInfoSucessState(mGetProfile));
  }

  void onLoadView() async {
    print("aaa");

    emit(ProfileLoadedState());
    // if (await checkNetworkStatus()) {
    //   emit(ProfileLoadedState());
    // } else {
    //   emit(GetProfileNointernetState());
    // }
  }

  void updateprofile({
    required int id,
    required String username,
    required String email,
    required String mobileno,
    required bool emailverified,
    required String dob,
    required String profileurl,
    required String password,
    required String devicetoken,
    required String gender,
  }) async {
    Loading(mLoaderGif).start(mContext);
    ApiResults apiResults = await LoginRepo().updateProfileData(
        id,
        username,
        email,
        mobileno,
        emailverified,
        dob,
        profileurl,
        password,
        devicetoken,
        gender);
    if (apiResults is ApiSuccess) {
      Loading.stop();
      handleProfileupdateResponse(
          apiResults.data, apiResults.statusCode, username);
    } else if (apiResults is ApiFailure) {
      Loading.stop();
      ErrorToast(context: mContext, text: "Login details Error");
    }
  }

  Future<void> handleProfileupdateResponse(
      json, int? statusCode, String email) async {
    if (ProfileResponse.fromJson(json).statusCode == 200) {
      getProfileInfo();
      SucessToast(
          context: mContext, text: ProfileResponse.fromJson(json).message);
    } else {
      ErrorToast(
          context: mContext, text: ProfileResponse.fromJson(json).message);
    }
  }
}
