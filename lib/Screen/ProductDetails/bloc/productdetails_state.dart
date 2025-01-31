import 'package:saveyoo/Model/StoreDetailsResponse.dart';
import 'package:saveyoo/Model/StoreProductResponse.dart';

abstract class ProductdetailsState {}

class ProductdetailsInitialState extends ProductdetailsState {}

class ProductdetailsLoadingState extends ProductdetailsState {}

class ProductdetailsLoadedState extends ProductdetailsState {}

class GetProductdetailsNointernetState extends ProductdetailsState {}

class GetProductdetailsInfoFailState extends ProductdetailsState {}

class GetProductdetailsInfoSucessState extends ProductdetailsState {
  final StoreProductData mGetStoreProduct;

  GetProductdetailsInfoSucessState(this.mGetStoreProduct);
}

class StoreLocationLoadingState extends ProductdetailsState {}

class StoreLocationLoadedState extends ProductdetailsState {}

class GetStoreLocationNointernetState extends ProductdetailsState {}

class GetStoreLocationInfoFailState extends ProductdetailsState {}

class GetStoreLocationInfoSucessState extends ProductdetailsState {
  List<Datum> mStoreDetailsData = [];
  GetStoreLocationInfoSucessState(this.mStoreDetailsData);
}
