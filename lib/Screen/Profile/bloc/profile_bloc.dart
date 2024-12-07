import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Profile/bloc/profile_event.dart';
import 'package:saveyoo/Screen/Profile/bloc/profile_state.dart';

import '../../../utils/pref_manager.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  ProfileBloc({required this.mContext}) : super(ProfileInitialState()) {
    on<SetProfileScreen>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void onLoadView() async {
    print("aaa");
    emit(GetProfileInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(ProfileLoadedState());
    // } else {
    //   emit(GetProfileNointernetState());
    // }
  }
}
