import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Model/SeeallResponse.dart';
import 'package:saveyoo/Network/api_result_handler.dart';
import 'package:saveyoo/Repository/login_repo.dart';
import 'package:saveyoo/Screen/SeeAll/bloc/seeall_event.dart';
import 'package:saveyoo/Screen/SeeAll/bloc/seeall_state.dart';

import '../../../utils/pref_manager.dart';

class SeeallBloc extends Bloc<SeeallEvent, SeeallState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;
  List<Datum> mSeeallData = [];
  SeeallBloc({required this.mContext}) : super(SeeallInitialState()) {
    on<SetSeeall>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void getViewallInfo(
      String latitude, String longitude, String radius, String category) async {
    //if (await checkNetworkStatus()) {

    ApiResults apiResults =
        await LoginRepo().getSellAll(latitude, longitude, radius, category);
    if (apiResults is ApiSuccess) {
      if (SeeallResponse.fromJson(apiResults.data).status) {
        handleDashboardResponse(apiResults.data);
      } else {
        emit(GetSeeallInfoFailState());
      }
    } else if (apiResults is ApiFailure) {
      emit(GetSeeallInfoFailState());
    }
  }

  void handleDashboardResponse(json) {
    mSeeallData = SeeallResponse.fromJson(json).data;

    emit(GetSeeallInfoSucessState(mSeeallData));
  }

  void onLoadView() async {
    emit(SeeallLoadedState());
  }
}
