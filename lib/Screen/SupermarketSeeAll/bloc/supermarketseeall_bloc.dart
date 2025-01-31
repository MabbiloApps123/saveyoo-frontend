import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Model/StoreResponse.dart';
import 'package:saveyoo/Network/api_result_handler.dart';
import 'package:saveyoo/Repository/login_repo.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_event.dart';
import 'package:saveyoo/Screen/SupermarketSeeAll/bloc/supermarketseeall_state.dart';

import '../../../utils/pref_manager.dart';

class SupermarketSeeallBloc
    extends Bloc<SupermarketSeeallEvent, SupermarketSeeallState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;
  List<StoreResponseDatum> mStoreList = [];

  SupermarketSeeallBloc({required this.mContext})
      : super(SupermarketSeeallInitialState()) {
    on<SetSupermarketSeeall>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void getStoreSeeall(String latitude, String longitude, String radius) async {
    //if (await checkNetworkStatus()) {

    ApiResults apiResults = await LoginRepo()
        .getStoreAll(latitude, longitude, radius, "supermarket");
    if (apiResults is ApiSuccess) {
      if (StoreResponse.fromJson(apiResults.data).status) {
        handleStoreResponse(apiResults.data);
      } else {
        emit(GetSupermarketSeeallInfoFailState());
      }
    } else if (apiResults is ApiFailure) {
      emit(GetSupermarketSeeallInfoFailState());
    }
    // } else {
    //   emit(GetDashboardNointernetState());
    // }
  }

  void handleStoreResponse(json) {
    mStoreList = StoreResponse.fromJson(json).data;

    emit(GetSupermarketSeeallInfoSucessState(mStoreList));
  }

  void onLoadView() async {
    emit(SupermarketSeeallLoadedState());
  }
}
