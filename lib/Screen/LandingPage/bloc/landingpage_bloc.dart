import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/LandingPage/bloc/landingpage_event.dart';
import 'package:saveyoo/Screen/LandingPage/bloc/landingpage_state.dart';

import '../../../utils/pref_manager.dart';

class LandingpageBloc extends Bloc<LandingpageEvent, LandingpageState> {
  StorageService storageService = StorageService();

  LandingpageBloc() : super(LandingpageInitialState()) {
    on<SetLandingpage>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      emit(LandingpageLoadedState());
      // onLoadView();
    });
  }

  void onLoadView() async {
    print("pp");
    emit(GetLandingpageInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(SplashLoadedState());
    // } else {
    //   emit(GetSplashNointernetState());
    // }
  }
}
