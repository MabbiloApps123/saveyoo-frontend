import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Model/GetFavouriteResponse.dart';
import 'package:saveyoo/Network/api_result_handler.dart';
import 'package:saveyoo/Repository/login_repo.dart';
import 'package:saveyoo/Screen/Favourites/bloc/favourites_event.dart';
import 'package:saveyoo/Screen/Favourites/bloc/favourites_state.dart';
import 'package:saveyoo/utils/constant.dart';

import '../../../utils/pref_manager.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  List<Datum> mFavData = [];

  FavouritesBloc({required this.mContext}) : super(FavouritesInitialState()) {
    on<SetFavouritesScreen>((event, emit) async {
      onLoadView();
    });
  }

  void getfavouriteInfo() async {
    //if (await checkNetworkStatus()) {

    String userId = await storageService.getString(Constant.MUSERID) ?? "1";

    ApiResults apiResults = await LoginRepo().getfavourite(userId);
    if (apiResults is ApiSuccess) {
      if (GetFavouriteResponse.fromJson(apiResults.data).status) {
        handleFavouriteResponse(apiResults.data);
      } else {
        emit(GetFavouritesInfoFailState());
      }
    } else if (apiResults is ApiFailure) {
      emit(GetFavouritesInfoFailState());
    }
    // } else {
    //   emit(GetDashboardNointernetState());
    // }
  }

  void handleFavouriteResponse(json) {
    mFavData = GetFavouriteResponse.fromJson(json).data;

    emit(GetFavouritesInfoSucessState(mFavData));
  }

  void onLoadView() async {
    print("aaa");
    emit(FavouritesLoadingState());
  }
}
