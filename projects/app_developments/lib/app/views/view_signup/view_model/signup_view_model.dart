// ignore_for_file: use_build_context_synchronously, invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_signup/view_model/signup_event.dart';
import 'package:app_developments/app/views/view_signup/view_model/signup_state.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/exceptions/sign_up_with_email_and_password_failure.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class SignupViewModel extends Bloc<SignupEvent, SignupState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Error message holders
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  StreamSubscription? _internetConnection;
  final bool isConnectedToInternet = false;

  // Define global key
  final formKey = GlobalKey<FormState>();
  SignupViewModel() : super(SignupInitialState()) {
    on<SignupInitialEvent>(_initial);
    on<SignupUserEvent>(_signupUserEvent);
  }

  FutureOr<void> _initial(SignupInitialEvent event, Emitter<SignupState> emit) {
    // Check for internet connection before proceeding
    _checkInternetConnection(event.context);
  }

  void _checkInternetConnection(BuildContext context) {
    try {
      _internetConnection = InternetConnection().onStatusChange.listen((event) {
        switch (event) {
          case InternetStatus.connected:
            if (state.isConnectedToInternet == false ||
                state.isConnectedToInternet == null) {
              _showInternetConnectedDialog(context);
            }
            emit(
              SignupInternetState(
                isConnectedToInternet: true,
              ),
            );
            break;
          case InternetStatus.disconnected:
            emit(
              SignupInternetState(
                isConnectedToInternet: false,
              ),
            );
            _showNoInternetDialog(context);
            break;
          default:
            emit(
              SignupInternetState(
                isConnectedToInternet: false,
              ),
            );
            _showNoInternetDialog(context);
            break;
        }
      });
    } catch (e) {
      throw Exception();
    }
  }

// Declare a variable to keep track of the dialog
  BuildContext? _noInternetDialogContext;

  void _showNoInternetDialog(BuildContext context) {
    try {
      // If the dialog is already open, do nothing
      if (_noInternetDialogContext != null) return;

      // Store the current dialog context to dismiss later
      _noInternetDialogContext = context;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'No Internet Connection',
                style:
                    TextStyle(color: ColorThemeUtil.getBgInverseColor(context)),
              ),
            ),
            content: Column(
              mainAxisSize:
                  MainAxisSize.min, // Prevents the dialog from being too tall
              children: [
                const Icon(
                  Icons.wifi_off,
                  color: AppLightColorConstants.errorColor,
                  size: 35,
                ),
                const SizedBox(height: 16), // Space between icon and text
                Text(
                  'Please check your internet connection and try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorThemeUtil.getBgInverseColor(context),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void _showInternetConnectedDialog(BuildContext context) {
    try {
      // Dismiss the no internet dialog if it's being displayed
      Navigator.of(_noInternetDialogContext!)
          .pop(); // Close the no internet dialog
      _noInternetDialogContext = null; // Reset the dialog context

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'You\'re Back Online',
                style:
                    TextStyle(color: ColorThemeUtil.getBgInverseColor(context)),
              ),
            ),
            content: Column(
              mainAxisSize:
                  MainAxisSize.min, // Prevents the dialog from being too tall
              children: [
                const Icon(
                  Icons.wifi,
                  color: AppLightColorConstants.successColor,
                  size: 35,
                ),
                const SizedBox(height: 16), // Space between icon and text
                Text(
                  'You are now connected to the internet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorThemeUtil.getBgInverseColor(context),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        color: ColorThemeUtil.getPrimaryColor(context)),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

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
          return Center(
              child: CircularProgressIndicator(
            color: ColorThemeUtil.getContentTeritaryColor(context),
          ));
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
      event.context.router.push(const ProfileUpdateViewRoute());

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
