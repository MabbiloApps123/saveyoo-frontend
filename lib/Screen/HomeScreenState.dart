abstract class HomeScreenState {}

class HomeInitial extends HomeScreenState {}

class HomeLoading extends HomeScreenState {}

class HomeLoaded extends HomeScreenState {
  final String data;

  HomeLoaded(this.data); // Replace `String data` with the actual data type.
}

class HomeError extends HomeScreenState {
  final String message;

  HomeError(this.message);
}
