import 'package:saveyoo/Model/ProfileResponse.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {}

class GetProfileNointernetState extends ProfileState {}

class GetProfileInfoFailState extends ProfileState {}

class GetProfileInfoSucessState extends ProfileState {
  final ProfileData mGetProfile;

  GetProfileInfoSucessState(this.mGetProfile);
}
