// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/core/auth/exceptions/log_in_with_email_and_password_failure.dart';
import 'package:app_developments/core/auth/exceptions/log_out_failure.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> signOut({
    required BuildContext context,
  }) async {
    try {
      await Future.wait(
        [
          _firebaseAuth.signOut(),
        ],
      );
      // Navigate to to signup screen
      context.router.push(const SignupViewRoute());
    } catch (e) {
      throw const LogOutFailure();
    }
  }

  /// Gets the current user's ID
  String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }
}
