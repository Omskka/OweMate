/* import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:flutter/material.dart'; // Ensure you import the necessary packages

// Exception class for handling login failures
class LogInWithEmailAndPasswordFailure implements Exception {
  final String? message;

  const LogInWithEmailAndPasswordFailure([this.message = '']);

 // Factory constructor to create a LogInWithEmailAndPasswordFailure based on the error code
  factory LogInWithEmailAndPasswordFailure.fromCode(String code, BuildContext context) {
    switch (code) {
      case 'invalid-credentials':
        return LogInWithEmailAndPasswordFailure(
          L10n.of(context)?.invalidCredentials,
        );
      case 'invalid-email':
        return LogInWithEmailAndPasswordFailure(
          L10n.of(context)?.invaildEmail,
        );
      case 'user-disabled':
        return LogInWithEmailAndPasswordFailure(
          L10n.of(context)?.userDisabled,
        );
      case 'user-not-found':
        return LogInWithEmailAndPasswordFailure(
          L10n.of(context)?.userNotFound,
        );
      case 'wrong-password':
        return LogInWithEmailAndPasswordFailure(
          L10n.of(context)?.wrongPassword,
        );
      default:
        return const LogInWithEmailAndPasswordFailure('An unknown exception occurred.');
    }
  }
}
 */
