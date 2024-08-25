import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get maxWidth and maxHeight from constraints
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        // Handle the case where maxWidth or maxHeight is Infinity
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        double buttonWidth;
        double buttonHeight;

        // Set fallback values if maxWidth or maxHeight is Infinity
        final effectiveMaxWidth =
            maxWidth == double.infinity ? screenWidth : maxWidth;
        final effectiveMaxHeight =
            maxHeight == double.infinity ? screenHeight : maxHeight;

        // Height
        if (effectiveMaxHeight <= 600) {
          buttonHeight = context.dynamicHeight(0.035);
        } else if (effectiveMaxHeight <= 800) {
          buttonHeight = context.dynamicHeight(0.035);
        } else if (effectiveMaxHeight <= 900) {
          buttonHeight = context.dynamicHeight(0.048);
        } else if (effectiveMaxHeight <= 1080) {
          buttonHeight = context.dynamicHeight(0.05);
        } else {
          buttonHeight = context.dynamicHeight(0.045);
        }

        // Width
        if (effectiveMaxWidth <= 600) {
          buttonWidth = context.dynamicWidth(0.2);
        } else if (effectiveMaxWidth <= 800) {
          buttonWidth = context.dynamicWidth(0.14);
        } else if (effectiveMaxWidth <= 900) {
          buttonWidth = context.dynamicWidth(0.12);
        } else if (effectiveMaxWidth <= 1080) {
          buttonWidth = context.dynamicWidth(0.1);
        } else {
          buttonWidth = context.dynamicWidth(0.07);
        }

        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                AppLightColorConstants.primaryColor, // Background color
            foregroundColor: Colors.white, // Text color
            minimumSize: Size(buttonWidth, buttonHeight), // Button size
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
      },
    );
  }
}
