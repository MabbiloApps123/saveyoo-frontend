import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Favourites/bloc/favourites_event.dart';
import 'package:saveyoo/Screen/Favourites/bloc/favourites_state.dart';

import '../../../utils/pref_manager.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  FavouritesBloc({required this.mContext}) : super(FavouritesInitialState()) {
    on<SetFavouritesScreen>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void onLoadView() async {
    print("aaa");
    emit(GetFavouritesInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(FavouritesLoadedState());
    // } else {
    //   emit(GetFavouritesNointernetState());
    // }
  }
}
