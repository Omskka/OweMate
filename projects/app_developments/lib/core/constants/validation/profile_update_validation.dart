import 'package:badword_guard/badword_guard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Modify ProfileUpdateValidation for synchronous checks
class ProfileUpdateValidation {
  // Synchronous name validation (no async logic)
  String? syncCheckValidName(String? value, BuildContext context) {
    final LanguageChecker checker = LanguageChecker();
    bool containsBadWord = checker.containsBadLanguage(value!);
    RegExp namePattern = RegExp(r'^[a-zA-ZğüşıöçĞÜŞİÖÇ]+$');

    // Check if textfield is empty
    if (value.isEmpty) {
      return 'Value Required';
    }

    if (value.length > 7) {
      return 'Username can\'t be longer than 7 charcters.';
    }

    // Check if name has more than two characters and is valid
    if (!namePattern.hasMatch(value) || value.length < 3) {
      return 'Invalid Name';
    }

    if (containsBadWord) {
      return 'Username contains inappropriate language.';
    }

    return null; // Synchronous validation passed
  }

  // Asynchronous check if the name exists in Firebase
  Future<String?> asyncCheckNameExists(String value) async {
    bool nameExists = await _checkNameExistsInFirebase(value);
    if (nameExists) {
      return 'A user with that username already exists';
    }
    return null;
  }

  // Firebase helper method (same as before)
  Future<bool> _checkNameExistsInFirebase(String name) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: name)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }
}
