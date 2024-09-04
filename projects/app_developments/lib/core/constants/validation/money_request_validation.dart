import 'package:flutter/material.dart';

class MoneyRequestValidation {
  // Function to check if amount is numerical and less than 100,000
  String? checkValidAmount(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }

    final numericValue = double.tryParse(value);
    if (numericValue == null) {
      return 'Amount must be a number';
    }

    if (numericValue >= 100000) {
      return 'Amount must be less than 100,000';
    }

    return null; // Valid
  }

  // Function to check if the message is less than 25 characters
  String? checkValidMessage(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Message is required';
    }

    if (value.length > 25) {
      return 'Message must be less than 25 characters';
    }

    return null; // Valid
  }
}
