import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:flutter/material.dart';

// Custom rounded button
class CustomRoundedButton extends StatelessWidget {
  final String? buttonText;
  final Icon? icon;
  final VoidCallback onPressed;

  const CustomRoundedButton({
    super.key,
    this.icon,
    this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            AppLightColorConstants.primaryColor, // Background color
        foregroundColor: Colors.white, // Text color
        minimumSize: const Size(63, 42), // Button size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Button border radius
        ),
        shadowColor: Colors.black, // Shadow color
        elevation: 5, // Shadow elevation
      ),
      child: buttonText != null
          ? Text(
              buttonText!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            )
          : Center(
              child: icon ??
                  Container(), // Display icon in the middle if no text is given
            ),
    );
  }
}
