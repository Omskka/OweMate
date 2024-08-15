import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:flutter/material.dart';

// Custom Continue Button
class CustomContinueButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Widget? icon;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  const CustomContinueButton({
    super.key,
    this.borderRadius,
    this.height,
    this.width,
    this.icon,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
        minimumSize: Size(width ?? 210, height ?? 65),
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
                BorderRadius.circular(20.0), //  default BorderRadius
          ),
        ),
      ),
    );
  }
}
