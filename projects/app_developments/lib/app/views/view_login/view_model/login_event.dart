import 'package:flutter/material.dart';

// Abstract base class for all login events
abstract class LoginEvent {
  LoginEvent();
}

// Event representing the initial state of the login process
class LoginInitialEvent extends LoginEvent {
  final BuildContext context;
  LoginInitialEvent({required this.context});
}

// Event triggered when the user attempts to sign in
class LoginSignInEvent extends LoginEvent {
  BuildContext context;

  // Constructor for the sign-in event, requires a BuildContext
  LoginSignInEvent({required this.context});
}

// Event triggered when the user attempts to sign in with google
class LoginGoogleSignInEvent extends LoginEvent {
  BuildContext context;

  // Constructor for the sign-in event, requires a BuildContext
  LoginGoogleSignInEvent({required this.context});
}

// Event triggered when user resets password
class LoginSendResetCodeEvent extends LoginEvent {
  BuildContext context;

  // Constructor for the sign-in event, requires a BuildContext
  LoginSendResetCodeEvent({required this.context});
}

// Event to navigate to the next page, holds the context for navigation and the selected page index
class LoginNavigateToNextPageEvent extends LoginEvent {
  final int selectedPage; // The index of the page to navigate to
  final BuildContext context; // The context used for navigation

  // Constructor to initialize the context and selected page index
  LoginNavigateToNextPageEvent({
    required this.context,
    required this.selectedPage,
  });
}
