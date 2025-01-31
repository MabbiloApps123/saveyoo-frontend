import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saveyoo/Model/StoreDetailsResponse.dart';
import 'package:saveyoo/Model/StoreProductResponse.dart';
import 'package:saveyoo/Network/api_result_handler.dart';
import 'package:saveyoo/Repository/login_repo.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_event.dart';
import 'package:saveyoo/Screen/ProductDetails/bloc/productdetails_state.dart';

import '../../../utils/pref_manager.dart';

class ProductdetailsBloc
    extends Bloc<ProductdetailsEvent, ProductdetailsState> {
  StorageService storageService = StorageService();
  final BuildContext mContext;
  StoreProductData mGetStoreProduct = StoreProductData();
  List<Datum> mStoreDetailsData = [];

  ProductdetailsBloc({required this.mContext})
      : super(ProductdetailsInitialState()) {
    on<SetProductdetails>((event, emit) async {
      onLoadView();
    });
  }

  void getProduct(String productId) async {
    //if (await checkNetworkStatus()) {

    ApiResults apiResults = await LoginRepo().getStoreProductbyId(productId);
    if (apiResults is ApiSuccess) {
      if (StoreProductResponse.fromJson(apiResults.data).status) {
        handleDashboardResponse(apiResults.data);
      } else {
        emit(GetProductdetailsInfoFailState());
      }
    } else if (apiResults is ApiFailure) {
      emit(GetProductdetailsInfoFailState());
    }
    // } else {
    //   emit(GetDashboardNointernetState());
    // }
  }

  void handleDashboardResponse(json) {
    mGetStoreProduct = StoreProductResponse.fromJson(json).data;

    emit(GetProductdetailsInfoSucessState(mGetStoreProduct));
  }

  void onLoadView() async {
    emit(ProductdetailsLoadingState());
  }

  void getStoreInfo(String storeId) async {
    //if (await checkNetworkStatus()) {

    ApiResults apiResults = await LoginRepo().getStoreDetailsbyId(storeId);
    if (apiResults is ApiSuccess) {
      if (StoreDetailsResponse.fromJson(apiResults.data).status) {
        handleStoreInfoResponse(apiResults.data);
      } else {
        emit(GetProductdetailsInfoFailState());
      }
    } else if (apiResults is ApiFailure) {
      emit(GetProductdetailsInfoFailState());
    }
    // } else {
    //   emit(GetDashboardNointernetState());
    // }
  }

  void handleStoreInfoResponse(json) {
    mStoreDetailsData = StoreDetailsResponse.fromJson(json).data;

    emit(GetStoreLocationInfoSucessState(mStoreDetailsData));
  }
}
