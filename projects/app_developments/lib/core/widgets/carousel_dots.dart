import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:flutter/material.dart';

class CarouselDots extends StatelessWidget {
  final int selectedPage;

  const CarouselDots({Key? key, required this.selectedPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // Dots are activated by selectedPage number
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDot(selectedPage == 1),
        buildDot(selectedPage == 2),
        buildDot(selectedPage == 3),
        buildDot(selectedPage == 4),
        // Add more dots if needed
      ],
    );
  }

  // Create a carousel slider widget
  Widget buildDot(bool isActive) {
    return Container(
      width: 25,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? AppLightColorConstants.primaryColor
            : AppLightColorConstants.secondaryColor,
      ),
    );
  }
}
