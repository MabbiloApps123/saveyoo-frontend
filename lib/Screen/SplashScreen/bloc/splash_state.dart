abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashSuccess extends SplashState {}

class SplashPermissionDenied extends SplashState {
  final String message;

  SplashPermissionDenied(this.message);
}

class SplashError extends SplashState {
  final String message;

  SplashError(this.message);
}
