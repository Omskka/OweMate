// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_signup/view_model/signup_event.dart';
import 'package:app_developments/app/views/view_signup/view_model/signup_state.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/exceptions/sign_up_with_email_and_password_failure.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupViewModel extends Bloc<SignupEvent, SignupState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Error message holders
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  // Define global key
  final formKey = GlobalKey<FormState>();
  SignupViewModel() : super(SignupInitialState()) {
    on<SignupInitialEvent>(_initial);
    on<SignupUserEvent>(_signupUserEvent);
  }

  FutureOr<void> _initial(
      SignupInitialEvent event, Emitter<SignupState> emit) {}

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  // Function to signup user
  Future<void> _signupUserEvent(
      SignupUserEvent event, Emitter<SignupState> emit) async {
    try {
      // Loading circle
      showDialog(
        context: event.context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      await AuthenticationRepository().signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: event.context,
      );
      // If signUp method completes without throwing an exception,
      // it indicates successful signup.

      // Emit a success state and display FlutterToast
      emit(SignupSuccessState());
      CustomFlutterToast(
              backgroundColor: AppLightColorConstants.successColor,
              context: event.context,
              msg: 'Signup Successfull')
          .flutterToast();

      // navigate to the next screen
      event.context.router.push(const LoginViewRoute());

      // Handle error if user creation failed (createUserWithEmailAndPassword should throw an exception on failure)
    } // Handle the custom exceptions thrown by the repository
    on SignUpWithEmailAndPasswordFailure catch (e) {
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      // Display a fluttertoast with the error message
      CustomFlutterToast(
        context: event.context,
        msg: e.message ?? "",
      ).flutterToast();
    }
  }
}
