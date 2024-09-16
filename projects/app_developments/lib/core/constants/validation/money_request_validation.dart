import 'package:flutter/material.dart';

class MoneyRequestValidation {
  // Function to check if amount is numerical, non-zero, less than 100,000, and has at most 2 decimal places
  String? checkValidAmount(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }

    final numericValue = double.tryParse(value);
    if (numericValue == null) {
      return 'Amount must be a number';
    }

    // Check if the amount is 0
    if (numericValue == 0) {
      return 'Amount cannot be 0';
    }

    // Check if the amount is greater than or equal to 100,000
    if (numericValue >= 100000) {
      return 'Amount must be less than 100,000';
    }

    // Check for up to 2 decimal places
    final regex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!regex.hasMatch(value)) {
      return 'Amount can have at most 2 decimal places';
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
