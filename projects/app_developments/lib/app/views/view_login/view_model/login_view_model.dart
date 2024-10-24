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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController resetEmailController = TextEditingController();
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
    on<LoginNavigateToNextPageEvent>(_navigateToNextPage);
    on<LoginSendResetCodeEvent>(_sendResetCode);
  }

  // Initial method to check if user is already logged in
  FutureOr<void> _initial(
      LoginInitialEvent event, Emitter<LoginState> emit) async {
    // Check for internet connection before proceeding
    _checkInternetConnection(event.context);

    // Check uncompleted account registers
    _deleteUncompletedAccounts();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Don't login in app initial start
    if (prefs.getBool('hasSeenHomeTutorial') == false) {
      AuthenticationRepository().signOut(context: event.context);
      bool? isLoggedIn = prefs.getBool('isLoggedIn');

      if (isLoggedIn ?? false) {
        // User is already logged in, navigate to HomeView
        event.context.router.push(const HomeViewRoute());
      }
    }
  }

  void _checkInternetConnection(BuildContext context) {
    try {
      _internetConnection = InternetConnection().onStatusChange.listen(
        (event) {
          switch (event) {
            case InternetStatus.connected:
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
              _showNoInternetDialog(context); // Show the dialog if disconnected
              break;
            default:
              emit(
                LoginInternetState(
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
      if (!kReleaseMode) {
        print(e);
      }
    }
  }

  FutureOr<void> _loginGoogleSignInEvent(
      LoginGoogleSignInEvent event, Emitter<LoginState> emit) async {
    try {
      String? status =
          await AuthenticationRepository().signInWithGoogle(event.context);

      if (status == null) {
        // Show a snackbar or handle the already active status
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('The account is already open.')),
          ),
        );
        AuthenticationRepository().signOut(context: event.context);
        return;
      }
    } catch (e) {
      if (!kReleaseMode) {
        print(e);
      }
    }
  }

  // Function to delete uncompleted accounts
  Future<void> _deleteUncompletedAccounts() async {
    final auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    try {
      final currentUser = auth.currentUser;

      // Check if the user is authenticated
      if (currentUser != null) {
        // Check if user information exists in Firestore
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(currentUser.uid).get();

        // If user info does not exist, delete the account
        if (!userDoc.exists) {
          await currentUser.delete(); // Deletes the user account
          if (!kReleaseMode) {
            print(
                'Deleted uncompleted account for email: ${currentUser.email}');
          }
        }
      }
    } catch (e) {
      if (!kReleaseMode) {
        print('Error deleting account: $e');
      }
    }
  }

  // Function to sign in user
  FutureOr<void> _loginSignInEvent(
      LoginSignInEvent event, Emitter<LoginState> emit) async {
    try {
      // Show loading circle
      showDialog(
        context: event.context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorThemeUtil.getContentTeritaryColor(context),
            ),
          );
        },
      );

      // Attempt to sign in with the provided email and password
      String? status = await AuthenticationRepository()
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              context: event.context);

      if (status == null) {
        // Show a snackbar or handle the already active status
        Navigator.of(event.context).pop();
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('The account is already open.')),
          ),
        );
        AuthenticationRepository().signOut(context: event.context);
        return;
      }

      // If SignIn method completes without throwing an exception,
      // it indicates successful SignIn.

      // Save login state
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Emit a success state and display FlutterToast
      emit(LoginSuccessState());
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Login Successful')),
          duration: Duration(seconds: 2), // Adjust duration as needed
        ),
      );

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

  FutureOr<void> _navigateToNextPage(
      LoginNavigateToNextPageEvent event, Emitter<LoginState> emit) {
    // Clear controller
    if (event.selectedPage == 1) {
      resetEmailController.clear();
    }
    emit(
      LoginPageIncrementState(
        selectedPage: event.selectedPage,
        isConnectedToInternet: state.isConnectedToInternet,
      ),
    );
  }

  FutureOr<void> _sendResetCode(
      LoginSendResetCodeEvent event, Emitter<LoginState> emit) async {
    try {
      // Email exists, send password reset email
      FirebaseAuth.instance.setLanguageCode('en');
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: resetEmailController.text.trim(),
      );
      // Show success dialog
      showDialog(
        context: event.context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Recovery Code Sent'),
            content: const Text(
                'Password reset link sent!\nPlease check your email.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: ColorThemeUtil.getContentPrimaryColor(
                      context,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle other errors (network issues, etc.)
      showDialog(
        context: event.context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: ColorThemeUtil.getContentPrimaryColor(
                      context,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _internetConnection?.cancel();
  }
}
