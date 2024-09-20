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
    return null;
  }

// Check for errors in password field
String? checkPasswordErrors(
  String? value,
  BuildContext context,
  TextEditingController passwordController,
) {
  // Regular expressions to check for required conditions
  RegExp capitalLetterPattern = RegExp(r'^(?=.*[A-Z])');  // At least one capital letter
  RegExp lowerCaseLetterPattern = RegExp(r'^(?=.*[a-z])'); // At least one non-capital (lowercase) letter
  RegExp numberPattern = RegExp(r'^(?=.*[0-9])');         // At least one number

  // Check if 'password' field is empty
  if (passwordController.text.isEmpty) {
    return 'Value is Required';
  }
  // Check if password length is at least 6 characters
  else if (passwordController.text.length <= 5) {
    return 'Password must contain at least 6 characters';
  }
  // Check if password contains at least one capital letter
  else if (!capitalLetterPattern.hasMatch(passwordController.text)) {
    return 'Password must contain at least one capital letter';
  }
  // Check if password contains at least one lowercase (non-capital) letter
  else if (!lowerCaseLetterPattern.hasMatch(passwordController.text)) {
    return 'Password must contain at least one lowercase letter';
  }
  // Check if password contains at least one number
  else if (!numberPattern.hasMatch(passwordController.text)) {
    return 'Password must contain at least one number';
  }

  return null; // Password is valid
}

// Check for errors in password field
String? checkLoginPasswordErrors(
  String? value,
  BuildContext context,
  TextEditingController passwordController,
) {        // At least one number

  // Check if 'password' field is empty
  if (passwordController.text.isEmpty) {
    return 'Value is Required';
  }
  // Check if password length is at least 6 characters
  else if (passwordController.text.length <= 5) {
    return 'Password must contain at least 6 characters';
  }

  return null; // Password is valid
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
