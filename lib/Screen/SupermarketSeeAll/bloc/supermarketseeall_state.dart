import 'package:saveyoo/Model/StoreResponse.dart';

abstract class SupermarketSeeallState {}

class SupermarketSeeallInitialState extends SupermarketSeeallState {}

class SupermarketSeeallLoadingState extends SupermarketSeeallState {}

class SupermarketSeeallLoadedState extends SupermarketSeeallState {}

class GetSupermarketSeeallNointernetState extends SupermarketSeeallState {}

class GetSupermarketSeeallInfoFailState extends SupermarketSeeallState {}

class GetSupermarketSeeallInfoSucessState extends SupermarketSeeallState {
  final List<StoreResponseDatum> mStoreList;
  GetSupermarketSeeallInfoSucessState(this.mStoreList);
}
