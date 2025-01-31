import 'package:saveyoo/Model/GetFavouriteResponse.dart';

abstract class FavouritesState {}

class FavouritesInitialState extends FavouritesState {}

class FavouritesLoadingState extends FavouritesState {}

class FavouritesLoadedState extends FavouritesState {}

class GetFavouritesNointernetState extends FavouritesState {}

class GetFavouritesInfoFailState extends FavouritesState {}

class GetFavouritesInfoSucessState extends FavouritesState {
  final List<Datum> mFavData;
  GetFavouritesInfoSucessState(this.mFavData);
}
