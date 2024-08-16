/* import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// SignIn Validation Class
class SignInValidation {

  // Function to validate email address
  String? checkValidEmail(
    String? value,
    BuildContext context,
    TextEditingController emailController,
  ) {
    // Regular expression for basic email validation
    String pattern = r'^[\w-\.]+@([\w-]+\.)+(com|net|org)$';
    RegExp regex = RegExp(pattern);

    // Check if 'email address' feild is empty
    if (emailController.text.isEmpty) {
      return L10n.of(context)?.valueRequired;
    }
    // Check if mail address is valid
    else if (!regex.hasMatch(value!)) {
      return L10n.of(context)?.invaildEmail;
    }
    return null;
  }

  // Function to validate password
  String? checkValidPassword(
    String? value,
    BuildContext context,
    TextEditingController passwordController,
  ) {
    // Check if 'password' feild is empty
    if (passwordController.text.isEmpty) {
      return L10n.of(context)?.valueRequired;
    }
    return null;
  }
}
 */