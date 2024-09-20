import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

// Custom Continue Button
class CustomSmallerContinueButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Widget? icon;
  final BorderRadiusGeometry? borderRadius;

  const CustomSmallerContinueButton({
    super.key,
    this.borderRadius,
    this.icon,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Width and height based on screen size
    double buttonWidth;
    double buttonHeight;

    // Height
    if (screenHeight <= 600) {
      // Small screens
      buttonHeight = context.dynamicHeight(0.085);
    } else if (screenHeight <= 800) {
      // Small screens
      buttonHeight = context.dynamicHeight(0.08);
    } else if (screenHeight <= 900) {
      // Medium screens
      buttonHeight = context.dynamicHeight(0.075);
    } else if (screenHeight <= 1080) {
      // Medium screens
      buttonHeight = context.dynamicHeight(0.065);
    } else {
      // Large screens
      buttonHeight = context.dynamicHeight(0.065);
    }

    // Width
    if (screenWidth <= 600) {
      // Very small screens
      buttonWidth = context.dynamicWidth(0.5);
    } else if (screenWidth <= 800) {
      // Small screens
      buttonWidth = context.dynamicWidth(0.28);
    } else if (screenWidth <= 900) {
      // Medium screens
      buttonWidth = context.dynamicWidth(0.28);
    } else if (screenWidth <= 1080) {
      // Medium Large screens
      buttonWidth = context.dynamicWidth(0.23);
    } else {
      // Large screens
      buttonWidth = context.dynamicWidth(0.1);
    }

    return ElevatedButton.icon(
      label: Text(
        buttonText,
        style: const TextStyle(
          letterSpacing: 1,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: onPressed,
      icon: icon ?? Container(),
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorThemeUtil.getPrimaryColor(context),
        foregroundColor: Colors.white,
        minimumSize: Size(buttonWidth, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              8.0), // Default radius value if none provided
        ),
        shadowColor: Colors.black,
        elevation: 5,
      ).copyWith(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius ??
                BorderRadius.circular(20.0), // Default BorderRadius
          ),
        ),
      ),
    );
  }
}
