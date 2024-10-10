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
    // Check uncompleted account registers
   // _deleteUncompletedAccounts();
  }

  void _checkInternetConnection(BuildContext context) {
    try {
      _internetConnection = InternetConnection().onStatusChange.listen(
        (event) {
          switch (event) {
            case InternetStatus.connected:
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
              _showNoInternetDialog(context); // Show the dialog if disconnected
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
        },
      );
    } catch (e) {
      throw Exception();
    }
  }

//  No internet pop-up
  void _showNoInternetDialog(BuildContext context) {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'No Internet Connection',
                style: TextStyle(
                  color: ColorThemeUtil.getBgInverseColor(context),
                ),
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
            actions: [
              TextButton(
                onPressed: () {
                  // Show the loading indicator for 1 second
                  showDialog(
                    context: context,
                    barrierDismissible:
                        false, // Prevents closing the dialog by tapping outside
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );

                  // Delay for 1 second, then pop the loading dialog and check the connection
                  Future.delayed(
                    const Duration(seconds: 1),
                    () {


                      if (state.isConnectedToInternet == true) {
                        Navigator.of(context).pop();
                        add(
                          SignupInitialEvent(context: context),
                        );
                      }

                      // Dismiss the original dialog
                      Navigator.of(context).pop();
                    },
                  );
                },
                child: Center(
                  child: Text(
                    'Try Again',
                    style: TextStyle(
                      color:
                          ColorThemeUtil.getMoneyRequesttAmountColor(context),
                    ),
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
