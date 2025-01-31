import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Model/HomePageResponse.dart';
import 'package:saveyoo/Network/api_result_handler.dart';
import 'package:saveyoo/Repository/login_repo.dart';
import 'package:saveyoo/Screen/Home/bloc/home_event.dart';
import 'package:saveyoo/Screen/Home/bloc/home_state.dart';
import 'package:saveyoo/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/pref_manager.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StorageService storageService = StorageService();
  Data mGetHome = Data();

  HomeBloc({required BuildContext mContext}) : super(HomeInitialState()) {
    on<SetHome>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      //emit(HomeLoadedState());
      onLoadView();
    });
  }

  void getDashboardInfo(
      String latitude, String longitude, String radius) async {
    //if (await checkNetworkStatus()) {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? Latitude = prefs.getDouble(Constant.MLATITUDE);
    double? Longitude = prefs.getDouble(Constant.MLONGITUDE);
    String? range = prefs.getString(Constant.MRANGE);

    ApiResults apiResults = await LoginRepo()
        .getHome(Latitude.toString(), Longitude.toString(), range!);
    if (apiResults is ApiSuccess) {
      if (HomePageResponse.fromJson(apiResults.data).status) {
        handleDashboardResponse(apiResults.data);
      } else {
        emit(GetHomeInfoFailState());
      }
    } else if (apiResults is ApiFailure) {
      emit(GetHomeInfoFailState());
    }
    // } else {
    //   emit(GetDashboardNointernetState());
    // }
  }

  void handleDashboardResponse(json) {
    mGetHome = HomePageResponse.fromJson(json).data;

    emit(GetHomeInfoSucessState(mGetHome));
  }

  void onLoadView() async {
    // emit(GetHomeInfoSucessState());
    //if (await checkNetworkStatu()) {
    emit(HomeLoadedState());
    // } else {
    //   emit(GetHomeNointernetState());
    // }
  }
}
