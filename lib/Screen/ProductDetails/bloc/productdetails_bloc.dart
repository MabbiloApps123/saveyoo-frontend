import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_event.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_state.dart';

import '../../../utils/pref_manager.dart';

class ProductdetailsBloc
    extends Bloc<ProductdetailsEvent, ProductdetailsState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;

  ProductdetailsBloc({required this.mContext})
      : super(ProductdetailsInitialState()) {
    on<SetProductdetails>((event, emit) async {
      // emit(SplashLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      // emit(SplashLoadedState());
      onLoadView();
    });
  }

  void onLoadView() async {
    print("aaa");
    emit(GetProductdetailsInfoSucessState());
    // if (await checkNetworkStatus()) {
    //   emit(OnboardingLoadedState());
    // } else {
    //   emit(GetOnboardingNointernetState());
    // }
  }
}
