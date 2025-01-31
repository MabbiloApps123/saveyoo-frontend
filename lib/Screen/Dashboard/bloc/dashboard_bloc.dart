import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/pref_manager.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  StorageService storageService = StorageService();

  final BuildContext mContext;
  DashboardBloc({
    required this.mContext,
  }) : super(DashboardInitialState()) {
    // onLoadView();
  }

  // void getDashboardInfo(String route, String db) async {
  //   if (await checkNetworkStatus()) {
  //     final userId = await sl<StorageService>().getString(Constant.MUSEREMAIL);
  //     final route = await sl<StorageService>()
  //             .getString(Constant.MDASHBOARDSELECTROUTE) ??
  //         "";
  //     final db =
  //         await sl<StorageService>().getString(Constant.MDASHBOARDSELECTDB) ??
  //             "";
  //     ApiResults apiResults =
  //         await DashboardRepository().getDashboardData(userId, route, db);
  //     if (apiResults is ApiSuccess) {
  //       if (DashboardResponse.fromJson(apiResults.data).message!.status!) {
  //         handleDashboardResponse(apiResults.data);
  //       } else {
  //         emit(GetDashboardInfoFailState());
  //       }
  //     } else if (apiResults is ApiFailure) {
  //       emit(GetDashboardInfoFailState());
  //     }
  //   } else {
  //     emit(GetDashboardNointernetState());
  //   }
  // }
  //
  // void handleDashboardResponse(json) {
  //   mGetDashboard = DashboardResponse.fromJson(json).message!.dashboard!;
  //
  //   emit(GetDashboardInfoSuccessState(mGetDashboard));
  // }

  // void onLoadView() async {
  //   if (await checkNetworkStatus()) {
  //     emit(DashboardLoadingState());
  //   } else {
  //     emit(GetDashboardNointernetState());
  //   }
  // }
}
