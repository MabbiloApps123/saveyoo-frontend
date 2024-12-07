import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/SetLocation/bloc/landingpage_event.dart';
import 'package:saveyoo/Screen/SetLocation/bloc/landingpage_state.dart';

import '../../../utils/pref_manager.dart';

class SetLocationBloc extends Bloc<SetLocationEvent, SetLocationState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  SetLocationBloc({
    required this.mContext,
  }) : super(SetLocationInitialState()) {
    on<SetSetLocation>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      emit(SetLocationLoadedState());
      // onLoadView();
    });
  }

  void onLoadView() async {
    print("pp");
    emit(GetSetLocationInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(SplashLoadedState());
    // } else {
    //   emit(GetSplashNointernetState());
    // }
  }
}
