import 'package:flutter/material.dart';

abstract class SignupEvent{
  SignupEvent();
}

// Initial event
class SignupInitialEvent extends SignupEvent{
  SignupInitialEvent();
}

// SignupUserEvent creating new users
class SignupUserEvent extends SignupEvent{
  final BuildContext context;
  SignupUserEvent({required this.context});
}