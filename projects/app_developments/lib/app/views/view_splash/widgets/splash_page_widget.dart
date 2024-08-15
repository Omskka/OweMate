import 'package:flutter/material.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';

class SplashPageWidget extends StatelessWidget {
  const SplashPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                        color: AppLightColorConstants.hueShadow
                            .withOpacity(0.3), // Hue shadow color
                        offset: const Offset(3.0, 0.0), // Offset to the right
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: 'MATE',
                  style: TextStyle(
                    color: AppLightColorConstants.ThirdColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 52,
                    fontFamily: 'Barlow Semi Condensed bold',
                    shadows: [
                      Shadow(
                        color: AppLightColorConstants.hueShadow
                            .withOpacity(0.3), // Hue shadow color
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
