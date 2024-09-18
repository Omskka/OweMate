import 'package:flutter/material.dart';

class FeedbackValidation {
  // Function to check if the message is less than 25 characters
  String? checkValidMessage(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Message is required';
    }

    if (value.length > 30) {
      return 'Message must be less than 30 characters';
    }

    return null; // Valid
  }
}
