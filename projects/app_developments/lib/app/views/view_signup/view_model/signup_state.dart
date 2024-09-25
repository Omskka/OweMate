abstract class SignupState {
  final bool? isConnectedToInternet;
  SignupState({this.isConnectedToInternet});
}

//Initial state
class SignupInitialState extends SignupState {
  SignupInitialState();
}

// state that indicates success
class SignupSuccessState extends SignupState {
  SignupSuccessState();
}

// state for chcking connection
class SignupInternetState extends SignupState {
  SignupInternetState({
    required bool? isConnectedToInternet,
  }) : super(
          isConnectedToInternet: isConnectedToInternet,
        );
}
