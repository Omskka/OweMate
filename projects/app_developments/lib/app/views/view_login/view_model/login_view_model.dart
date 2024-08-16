// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_login/view_model/login_event.dart';
import 'package:app_developments/app/views/view_login/view_model/login_state.dart';
import 'package:app_developments/core/auth/exceptions/log_in_with_email_and_password_failure.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserCredential? userCredential;

  // Define global key
  final formKey = GlobalKey<FormState>();

  LoginViewModel() : super(LoginInitialState()) {
    on<LoginInitialEvent>(_initial);
    on<LoginSignInEvent>(_loginSignInEvent);
  }

  FutureOr<void> _initial(LoginInitialEvent event, Emitter<LoginState> emit) {
    // Initial setup if any
  }

  // Function to sign in user
  FutureOr<String?> _loginSignInEvent(
      LoginSignInEvent event, Emitter<LoginState> emit) async {
    try {
      // Loading circle
      showDialog(
        context: event.context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      // Attempt to sign in with the provided email and password
      await AuthenticationRepository().signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: event.context);

      // If SignIn method completes without throwing an exception,
      // it indicates successful SignIn.

      // Emit a success state and display FlutterToast
      emit(LoginSuccessState());
      CustomFlutterToast(
              backgroundColor: AppLightColorConstants.successColor,
              context: event.context,
              msg: 'Login Successfull')
          .flutterToast();

      // navigate to the next screen
      event.context.router.push(const OnboardingViewRoute());
    }

    // Handle the custom exceptions thrown by the repository
    on LogInWithEmailAndPasswordFailure catch (e) {
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      // Display a fluttertoast with the error message
      CustomFlutterToast(
        context: event.context,
        msg: e.message ?? 'Invalid Credentails',
      ).flutterToast();
    }
    return null;
  }
}
