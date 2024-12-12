import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_event.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_state.dart';

import '../../../utils/pref_manager.dart';

class SupermarketSeeallBloc
    extends Bloc<SupermarketSeeallEvent, SupermarketSeeallState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  SupermarketSeeallBloc({required this.mContext})
      : super(SupermarketSeeallInitialState()) {
    on<SetSupermarketSeeall>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void onLoadView() async {
    print("aaa");
    emit(GetSupermarketSeeallInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(OnboardingLoadedState());
    // } else {
    //   emit(GetOnboardingNointernetState());
    // }
  }
}
