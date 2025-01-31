import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Browser/bloc/browser_event.dart';
import 'package:saveyoo/Screen/Browser/bloc/browser_state.dart';

import '../../../utils/pref_manager.dart';

class BrowserBloc extends Bloc<BrowserEvent, BrowserState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  BrowserBloc({required this.mContext}) : super(BrowserInitialState()) {
    on<SetBrowser>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void onLoadView() async {
    print("aaa");
    emit(GetBrowserInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(OnboardingLoadedState());
    // } else {
    //   emit(GetOnboardingNointernetState());
    // }
  }
}
