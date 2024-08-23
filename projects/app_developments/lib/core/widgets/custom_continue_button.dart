import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

// Custom Continue Button
class CustomContinueButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Widget? icon;
  final BorderRadiusGeometry? borderRadius;

  const CustomContinueButton({
    super.key,
    this.borderRadius,
    this.icon,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        // Width and height based on screen size
        double buttonWidth;
        double buttonHeight;

        // Height
        if (maxHeight <= 600) {
          // Small screens
          buttonHeight = context.dynamicHeight(0.065);
        } else if (maxHeight <= 800) {
          // Small screens
          buttonHeight = context.dynamicHeight(0.007);
        } else if (maxHeight <= 900) {
          // Medium screens
          buttonHeight = context.dynamicHeight(0.0075);
        } else if (maxHeight <= 1080) {
          // Medium screens
          buttonHeight = context.dynamicHeight(0.07);
        } else {
          // Large screens
          buttonHeight = context.dynamicHeight(0.075);
        }

        // Width
        if (maxWidth <= 600) {
          // Very small screens
          buttonWidth = context.dynamicWidth(0.6);
        } else if (maxWidth <= 800) {
          // Small screens
          buttonWidth = context.dynamicWidth(0.4);
        } else if (maxWidth <= 900) {
          // Medium screens
          buttonWidth = context.dynamicWidth(0.4);
        } else if (maxWidth <= 1080) {
          // Medium Large screens
          buttonWidth = context.dynamicWidth(0.3);
        } else {
          // Large screens
          buttonWidth = context.dynamicWidth(0.25);
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
            backgroundColor: AppLightColorConstants.primaryColor,
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
      },
    );
  }
}
