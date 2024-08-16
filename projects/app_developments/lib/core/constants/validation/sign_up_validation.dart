import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SignUpValidation {
  // Check for errors in email field
  String? checkMailErrors(
    String? value,
    BuildContext context,
    TextEditingController emailController,
  ) {
    // Check if 'email address' feild is empty
    if (emailController.text.isEmpty) {
      return 'Value is Required';
    }
    // Check if email address is valid
    // Regular expression for basic email validation
    String pattern = r'^[\w-\.]+@([\w-]+\.)+(com|net|org)$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Invalid Email Format';
    }
    //print('retuned null');
    return null;
  }

  // Check for errors in password field
  String? checkPasswordErrors(
    String? value,
    BuildContext context,
    TextEditingController passwordController,
  ) {
    // Check if 'password' feild is empty
    if (passwordController.text.isEmpty) {
      return 'Value is Required';
    }
    // Check if password is valid
    else if (passwordController.text.length <= 5) {
      return 'Password must contain atleast 6 characters';
    }
    return null;
  }

  // Check for errors in confirm password field
  String? checkConfirmPasswordErrors(
      String? value,
      BuildContext context,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) {
    // Check if 'confirm password' feild is empty
    if (passwordController.text.isEmpty) {
      return 'Value is Required';
    }
    // Check if passwords match
    else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      return 'Passwords do not match!';
    }
    return null;
  }
}
