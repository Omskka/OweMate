import 'package:badword_guard/badword_guard.dart';
import 'package:flutter/material.dart';

class FeedbackValidation {
  // Function to check if the message is less than 25 characters
  String? checkValidMessage(String? value, BuildContext context) {
    final LanguageChecker checker = LanguageChecker();
    bool containsBadLanguage = checker.containsBadLanguage(value!);

    if (value.isEmpty) {
      return 'Message is required';
    }

    if (value.length > 50) {
      return 'Message must be less than 50 characters';
    }

    if (containsBadLanguage) {
      return 'Message contains inappropriate language.';
    }

    return null; // Valid
  }
}
