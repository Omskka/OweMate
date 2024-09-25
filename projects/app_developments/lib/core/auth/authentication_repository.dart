// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/core/auth/exceptions/log_in_with_email_and_password_failure.dart';
import 'package:app_developments/core/auth/exceptions/log_out_failure.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_developments/core/auth/exceptions/sign_up_with_email_and_password_failure.dart';
import 'package:flutter/material.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  /// Creates a new user with the provided [email] and [password].
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<String?> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code, context);
    } catch (e) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code, context);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [GoogleAccount].
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Sign out from any previous Google account to prompt account selection
      await googleSignIn.signOut();

      // Start the Google sign-in process
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      // If the user cancels the sign-in process
      if (gUser == null) {
        return;
      }

      // Obtain auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create Firebase credentials with Google tokens
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user is new (i.e., first-time sign-in)
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        // Navigate to the update profile page for new users
        context.router.replace(const ProfileUpdateViewRoute());
      } else {
        // Navigate to the home page for existing users
        context.router.replace(const HomeViewRoute());
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-related exceptions (e.g., sign-in errors)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } catch (e) {
      // Handle any other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong. Please try again.')),
      );
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> signOut({
    required BuildContext context,
  }) async {
    try {
      // Optionally, clear SharedPreferences or any other local storage data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clears all stored data

      // Sign out from Firebase Authentication
      await _firebaseAuth.signOut();

      // Alternatively, you can clear specific keys:
      await prefs.remove('isLoggedIn');

      // Navigate to the sign-up screen
      context.router.replace(const LoginViewRoute());
    } catch (e) {
      throw const LogOutFailure();
    }
  }

  /// Gets the current user's ID
  String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  Future<void> deleteAccount({
    required BuildContext context,
  }) async {
    try {
      // Navigate to the login page
      context.router.push(const LoginViewRoute());

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              'Account deleted successfully.',
              style: TextStyle(
                color: AppLightColorConstants.successColor,
              ),
            ),
          ),
        ),
      );

      // Get the current user
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        // Optionally: delete user data from Firestore or other services here.
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();

        // Delete the user account
        await user.delete();

        // Clear any stored preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      } else {
        throw Exception('User not found or email does not match.');
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase exceptions as needed
      throw Exception('Failed to delete account: ${e.message}');
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Something went wrong. Please try again.');
    }
  }
}
