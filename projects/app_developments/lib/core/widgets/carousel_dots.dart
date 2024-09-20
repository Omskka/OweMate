import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:flutter/material.dart';

class CarouselDots extends StatelessWidget {
  final int selectedPage;

  const CarouselDots({
    Key? key,
    required this.selectedPage,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      // Dots are activated by selectedPage number
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDot(context, selectedPage == 1),
        buildDot(context, selectedPage == 2),
        buildDot(context, selectedPage == 3),
        buildDot(context, selectedPage == 4),
        // Add more dots if needed
      ],
    );
  }

  // Create a carousel slider widget with access to context
  Widget buildDot(BuildContext context, bool isActive) {
    return Container(
      width: 25,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? ColorThemeUtil.getPrimaryColor(context)
            : ColorThemeUtil.getSecondaryColor(context),
      ),
    );
  }
}
