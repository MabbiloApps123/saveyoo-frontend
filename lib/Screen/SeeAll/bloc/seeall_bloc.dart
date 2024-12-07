import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/SeeAll/bloc/seeall_event.dart';
import 'package:saveyoo/Screen/SeeAll/bloc/seeall_state.dart';

import '../../../utils/pref_manager.dart';

class SeeallBloc extends Bloc<SeeallEvent, SeeallState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  SeeallBloc({required this.mContext}) : super(SeeallInitialState()) {
    on<SetSeeall>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void onLoadView() async {
    print("aaa");
    emit(GetSeeallInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(OnboardingLoadedState());
    // } else {
    //   emit(GetOnboardingNointernetState());
    // }
  }
}
