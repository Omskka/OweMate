import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// Exception class for handling sign-up failures
class SignUpWithEmailAndPasswordFailure implements Exception {
  final String? message;

  // Constructor for SignUpWithEmailAndPasswordFailure with an optional message
  const SignUpWithEmailAndPasswordFailure([
    this.message = '',
  ]);

  // A named constructor which will return different message
  // based on the provided code.
  factory SignUpWithEmailAndPasswordFailure.fromCode(
      String code, BuildContext context) {
    switch (code) {
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
          'Email is already in use',
        );
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure(
          'Invalid email address',
        );
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
          'Operation not allowed',
        );
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
          'Weak password',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
