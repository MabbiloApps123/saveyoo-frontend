import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Home/bloc/home_event.dart';
import 'package:saveyoo/Screen/Home/bloc/home_state.dart';

import '../../../utils/pref_manager.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StorageService storageService = StorageService();

  HomeBloc({required BuildContext mContext}) : super(HomeInitialState()) {
    on<SetHome>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      emit(HomeLoadedState());
      // onLoadView();
    });
  }

  void onLoadView() async {
    print("pp");
    emit(GetHomeInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(SplashLoadedState());
    // } else {
    //   emit(GetSplashNointernetState());
    // }
  }
}
