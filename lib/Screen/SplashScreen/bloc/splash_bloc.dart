import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/SplashScreen/bloc/splash_event.dart';
import 'package:saveyoo/Screen/SplashScreen/bloc/splash_state.dart';

import '../../../utils/pref_manager.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  StorageService storageService = StorageService();

  SplashBloc() : super(SplashInitialState()) {
    on<SetSplash>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      emit(SplashLoadedState());
      // onLoadView();
    });
  }

  void onLoadView() async {
    print("pp");
    emit(SplashLoadedState());
    // if (await checkNetworkStatus()) {
    //   emit(SplashLoadedState());
    // } else {
    //   emit(GetSplashNointernetState());
    // }
  }
}
