/* import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ProfileUpdateValidation{
  // Function to check valid name
  String? checkValidName(String? value, BuildContext context) {
    // validation logic for name and surname
    // name should be longer than one characters
    RegExp namePattern = RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ]');

    // Check if textfield is empty
    if (value == null || value.isEmpty) {
      return L10n.of(context)?.valueRequired;
      // Check if name has more than two characters
    }

    if (!namePattern.hasMatch(value) || value.length < 3) {
      return L10n.of(context)?.invalidName;
    }
    return null;
  }

  // Function to check valid surname
  String? checkValidSurName(String? value, BuildContext context) {
    // validation logic for name and surname
    RegExp namePattern = RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ]');

    // Check if textfield is empty
    if (value == null || value.isEmpty) {
      return L10n.of(context)?.valueRequired;
      // Check if Last name has more than two characters
    } else if (!namePattern.hasMatch(value) || value.length < 3) {
      return L10n.of(context)?.invalidLastName;
    }
    return null;
  }
} */