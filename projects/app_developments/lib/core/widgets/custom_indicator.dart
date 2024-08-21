import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:flutter/material.dart';

// Custom indicator shape for navbar
class CustomRoundedTopBorderShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(0);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    const radius = Radius.circular(30); // Adjust the radius as needed

    // Adjuct Indicator shape
    path.addRRect(RRect.fromLTRBAndCorners(
      rect.left + 5,
      rect.top - 8,
      rect.right - 5,
      rect.bottom + 34,
      // Make the top circular
      topLeft: radius,
      topRight: radius,
    ));
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // For a simple case where the inner path is the same as the outer path
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final paint = Paint()
      ..color = AppLightColorConstants.primaryColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(getOuterPath(rect, textDirection: textDirection), paint);
  }

  @override
  ShapeBorder scale(double t) => this;
}
