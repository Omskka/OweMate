// ignore: non_constant_identifier_names
abstract class LoginState {
  final bool? isConnectedToInternet;
  final int? selectedPage;
  LoginState({
    this.isConnectedToInternet,
    this.selectedPage,
  });
}

// Initial state
class LoginInitialState extends LoginState {
  LoginInitialState():super(
    selectedPage: 1,
  );
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

// State for incrementing the selected page
class LoginPageIncrementState extends LoginState {
  LoginPageIncrementState({
    int? selectedPage,
    required bool? isConnectedToInternet,
  }) : super(
          selectedPage: selectedPage,
        );
}
