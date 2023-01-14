abstract class SocialLoginStates {}

class LoginInitiateState extends SocialLoginStates {}

class LoginLoadingState extends SocialLoginStates {}

class LoginSuccessState extends SocialLoginStates {
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends SocialLoginStates {
  final String error;
  LoginErrorState(this.error);
}
