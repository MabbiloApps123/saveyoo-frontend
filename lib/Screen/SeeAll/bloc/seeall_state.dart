import 'package:saveyoo/Model/SeeallResponse.dart';

abstract class SeeallState {}

class SeeallInitialState extends SeeallState {}

class SeeallLoadingState extends SeeallState {}

class SeeallLoadedState extends SeeallState {}

class GetSeeallNointernetState extends SeeallState {}

class GetSeeallInfoFailState extends SeeallState {}

class GetSeeallInfoSucessState extends SeeallState {
  final List<Datum> mSeeallData;
  GetSeeallInfoSucessState(this.mSeeallData);
}
