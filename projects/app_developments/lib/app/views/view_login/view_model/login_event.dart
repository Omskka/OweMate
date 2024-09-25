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
