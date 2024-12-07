//

abstract class RegisterStatus {}

class RegisterInitialState extends RegisterStatus {}

class RegisterLoadingState extends RegisterStatus {}

class NointernetState extends RegisterStatus {}

class GetRegisterInfoFailState extends RegisterStatus {
  final String mMessage;
  GetRegisterInfoFailState(this.mMessage);
}

class GetRegisterInfoSuccessState extends RegisterStatus {
  final String mMessage;
  GetRegisterInfoSuccessState(this.mMessage);
}
