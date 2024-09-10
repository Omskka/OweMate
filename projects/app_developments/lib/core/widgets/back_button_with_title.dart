import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_rounded_button.dart';
import 'package:flutter/material.dart';

class BackButtonWithTitle extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  const BackButtonWithTitle({
    required this.title,
    required this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // Determine height and width based on screen dimensions
    double buttonLeftPosition;

    // Height
    if (screenHeight <= 680) {
      // Small screens
    } else if (screenHeight <= 800) {
      // Small screens
    } else if (screenHeight <= 900) {
      // Medium screens
    } else if (screenHeight <= 1080) {
      // Medium screens
    } else {
      // Large screens
    }

    // Width
    if (screenWidth <= 600) {
      // very Small screens
      buttonLeftPosition = context.dynamicWidth(0.09);
    } else if (screenWidth <= 800) {
      // Small screens
      buttonLeftPosition = context.dynamicWidth(0.12);
    } else if (screenWidth <= 900) {
      // Medium screens
      buttonLeftPosition = context.dynamicWidth(0.15);
    } else if (screenWidth <= 1080) {
      // Medium Large screens
      buttonLeftPosition = context.dynamicWidth(0.2);
    } else {
      // Large screens
      buttonLeftPosition = context.dynamicWidth(0.25);
    }
    return Padding(
      padding: context.onlyTopPaddingMedium,
      child: SizedBox(
        height: context.dynamicHeight(0.085),
        width: context.dynamicWidth(1),
        child: Stack(
          children: [
            Positioned(
              top: context.dynamicHeight(0.02),
              left: buttonLeftPosition,
              child: CustomRoundedButton(
                  icon: const Icon(Icons.arrow_back), onPressed: ontap),
            ),
            Center(
              child: Text(
                title,
                style: context.textStyleTitleBarlow(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
