// ignore_for_file: use_build_context_synchronously, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_login/view_model/login_event.dart';
import 'package:app_developments/app/views/view_login/view_model/login_state.dart';
import 'package:app_developments/core/auth/exceptions/log_in_with_email_and_password_failure.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserCredential? userCredential;

  // Define global key
  final formKey = GlobalKey<FormState>();

  StreamSubscription? _internetConnection;
  final bool isConnectedToInternet = false;

  LoginViewModel() : super(LoginInitialState()) {
    on<LoginInitialEvent>(_initial);
    on<LoginSignInEvent>(_loginSignInEvent);
    on<LoginGoogleSignInEvent>(_loginGoogleSignInEvent);
  }

  // Initial method to check if user is already logged in
  FutureOr<void> _initial(
      LoginInitialEvent event, Emitter<LoginState> emit) async {
    // Check for internet connection before proceeding
    _checkInternetConnection(event.context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');

    if (isLoggedIn ?? false) {
      // User is already logged in, navigate to HomeView
      event.context.router.push(const HomeViewRoute());
    }
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
              LoginInternetState(
                isConnectedToInternet: true,
              ),
            );
            break;
          case InternetStatus.disconnected:
            emit(
              LoginInternetState(
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

// Declare a variable to keep track of the dialog state
  bool _isNoInternetDialogVisible = false;

// Updated method to show the "No Internet" dialog
  void _showNoInternetDialog(BuildContext context) {
    try {
      // If the dialog is already visible, do nothing
      if (_isNoInternetDialogVisible) return;

      // Mark the dialog as visible
      _isNoInternetDialogVisible = true;

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
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.wifi_off,
                  color: AppLightColorConstants.errorColor,
                  size: 35,
                ),
                const SizedBox(height: 16),
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
      ).then((_) {
        // When the dialog is dismissed, mark it as not visible
        _isNoInternetDialogVisible = false;
      });
    } catch (e) {
      print(e);
    }
  }

// Updated method to show the internet connected dialog
  void _showInternetConnectedDialog(BuildContext context) {
    try {
      // If there is no dialog currently displayed, do nothing
      if (!_isNoInternetDialogVisible) return;

      // Dismiss the "No Internet" dialog if it is visible
      Navigator.of(context).pop();
      _isNoInternetDialogVisible = false;

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
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.wifi,
                  color: AppLightColorConstants.successColor,
                  size: 35,
                ),
                const SizedBox(height: 16),
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

  FutureOr<void> _loginGoogleSignInEvent(
      LoginGoogleSignInEvent event, Emitter<LoginState> emit) {
    try {
      AuthenticationRepository().signInWithGoogle(event.context);
    } catch (e) {
      print(e);
    }
  }

  // Function to sign in user
  FutureOr<String?> _loginSignInEvent(
      LoginSignInEvent event, Emitter<LoginState> emit) async {
    try {
      // Show loading circle
      showDialog(
        context: event.context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: ColorThemeUtil.getContentTeritaryColor(context),
          ));
        },
      );

      // Attempt to sign in with the provided email and password
      await AuthenticationRepository().signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: event.context);

      // If SignIn method completes without throwing an exception,
      // it indicates successful SignIn.

      // Save login state
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Emit a success state and display FlutterToast
      emit(LoginSuccessState());
      CustomFlutterToast(
              backgroundColor: AppLightColorConstants.successColor,
              context: event.context,
              msg: 'Login Successful')
          .flutterToast();

      // Navigate to the next screen
      event.context.router.push(const HomeViewRoute());
    }

    // Handle the custom exceptions thrown by the repository
    on LogInWithEmailAndPasswordFailure catch (e) {
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      // Display a fluttertoast with the error message
      CustomFlutterToast(
        context: event.context,
        msg: e.message ?? 'Invalid Credentials',
      ).flutterToast();
    }
    return null;
  }

  @override
  void dispose() {
    _internetConnection?.cancel();
  }
}
