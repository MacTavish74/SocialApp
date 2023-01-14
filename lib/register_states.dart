
abstract class SocialRegisterStates {}

class RegisterInitiateState extends SocialRegisterStates {}

class RegisterLoadingState extends SocialRegisterStates {}

class RegisterSuccessState extends SocialRegisterStates {
  
}

class RegisterErrorState extends SocialRegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends SocialRegisterStates {
  
}

class CreateUserErrorState extends SocialRegisterStates {
  final String error;
  CreateUserErrorState(this.error);
}
