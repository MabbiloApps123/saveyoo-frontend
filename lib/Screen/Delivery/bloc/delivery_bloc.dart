import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/Delivery/bloc/delivery_event.dart';
import 'package:saveyoo/Screen/Delivery/bloc/delivery_state.dart';

import '../../../utils/pref_manager.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  DeliveryBloc({required this.mContext}) : super(DeliveryInitialState()) {
    on<SetDeliveryScreen>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void onLoadView() async {
    print("aaa");
    emit(GetDeliveryInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(DeliveryLoadedState());
    // } else {
    //   emit(GetDeliveryNointernetState());
    // }
  }
}
