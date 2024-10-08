import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:flutter/material.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';

class SplashPageWidget extends StatelessWidget {
  const SplashPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the current theme is dark or light
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.center,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'OWE',
                  style: TextStyle(
                    color: AppLightColorConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 52,
                    fontFamily: 'Barlow Semi Condensed bold',
                    shadows: [
                      Shadow(
                        color: isDarkMode
                            ? ColorThemeUtil.getHueColor(context)
                                .withOpacity(0.65)
                            : ColorThemeUtil.getHueColor(context)
                                .withOpacity(0.3),
                        offset: const Offset(3.0, 0.0), // Offset to the right
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: 'MATE',
                  style: TextStyle(
                    color: AppLightColorConstants.thirdColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 52,
                    fontFamily: 'Barlow Semi Condensed bold',
                    shadows: [
                      Shadow(
                        color: isDarkMode
                            ? ColorThemeUtil.getHueColor(context)
                                .withOpacity(0.65)
                            : ColorThemeUtil.getHueColor(context)
                                .withOpacity(0.3),
                        offset: const Offset(3.0, 0.0), // Offset to the right
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
