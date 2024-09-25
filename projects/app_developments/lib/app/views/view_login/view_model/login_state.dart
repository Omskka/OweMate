// ignore: non_constant_identifier_names
abstract class LoginState {
  final bool? isConnectedToInternet;
  LoginState({
    this.isConnectedToInternet,
  });
}

// Initial state
class LoginInitialState extends LoginState {
  LoginInitialState();
}

// Success state
class LoginSuccessState extends LoginState {
  LoginSuccessState();
}

// Failiure state
class LoginFailureState extends LoginState {
  final String error;

  // Constructor for the failure state, requires an error message
  LoginFailureState({
    required this.error,
  });
}

class LoginInternetState extends LoginState {
  LoginInternetState({
    required bool? isConnectedToInternet,
  }) : super(
          isConnectedToInternet: isConnectedToInternet,
        );
}
