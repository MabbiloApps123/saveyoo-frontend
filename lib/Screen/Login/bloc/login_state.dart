//

abstract class LoginStatus {}

class LoginInitialState extends LoginStatus {}

class LoginLoadingState extends LoginStatus {}

class GetLoginInfoFailState extends LoginStatus {
  final String mMessage;
  GetLoginInfoFailState(this.mMessage);
}

class GetLoginInfoSuccessState extends LoginStatus {
  final String mMessage;
  GetLoginInfoSuccessState(this.mMessage);
}
