import 'package:saveyoo/Model/HomePageResponse.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {}

class GetHomeNointernetState extends HomeState {}

class GetHomeInfoFailState extends HomeState {}

class GetHomeInfoSucessState extends HomeState {
  final Data mHomeData;
  GetHomeInfoSucessState(this.mHomeData);
}
