import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Browse/bloc/browse_event.dart';
import 'package:saveyoo/Screen/Browse/bloc/browse_state.dart';

import '../../../utils/pref_manager.dart';

class BrowseBloc extends Bloc<BrowseEvent, BrowseState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  BrowseBloc({required this.mContext}) : super(BrowseInitialState()) {
    on<SetBrowseScreen>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void onLoadView() async {
    print("aaa");
    emit(GetBrowseInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(BrowseLoadedState());
    // } else {
    //   emit(GetBrowseNointernetState());
    // }
  }
}
