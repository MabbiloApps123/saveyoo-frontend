abstract class SetLocationState {}

class SetLocationInitialState extends SetLocationState {}

class SetLocationLoadingState extends SetLocationState {}

class SetLocationLoadedState extends SetLocationState {}

class GetSetLocationNointernetState extends SetLocationState {}

class GetSetLocationInfoFailState extends SetLocationState {}

class GetSetLocationInfoSucessState extends SetLocationState {}
