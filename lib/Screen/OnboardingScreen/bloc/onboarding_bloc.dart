import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/OnboardingScreen/bloc/onboarding_event.dart';
import 'package:saveyoo/Screen/OnboardingScreen/bloc/onboarding_state.dart';

import '../../../utils/pref_manager.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  OnboardingBloc({required this.mContext}) : super(OnboardingInitialState()) {
    on<SetOnboarding>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void onLoadView() async {
    print("aaa");
    emit(GetOnboardingInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(OnboardingLoadedState());
    // } else {
    //   emit(GetOnboardingNointernetState());
    // }
  }
}
