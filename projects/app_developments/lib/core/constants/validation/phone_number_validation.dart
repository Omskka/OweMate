import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PhoneNumberValidation {
  // Function to check phone number validation
  String? validatePhoneNumber(
    BuildContext context,
    String? value,
    TextEditingController phoneNumberController,
  ) {
    // Remove all non-digit characters and format the phone number
    final text = value?.replaceAll(RegExp(r'\D'), '') ?? '';
    final formattedText = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) formattedText.write(' ');
      formattedText.write(text[i]);
    }

    // Schedule the update after the current frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      phoneNumberController.value = TextEditingValue(
        text: formattedText.toString(),
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    });

    // Regular expression to match the phone number format
    final RegExp phoneRegExp = RegExp(r'^(\d{3}) (\d{3}) (\d{4})$');

    // Check if textfield is empty
    if (phoneNumberController.text.isEmpty) {
      return 'Value Required';
    }

    // Check if the phone number format is valid
    if (!phoneRegExp.hasMatch(phoneNumberController.text)) {
      return 'Invalid phone number format';
    }
    return null;
  }
}
