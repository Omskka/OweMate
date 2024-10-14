import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomProfileCard extends StatelessWidget {
  final String title;
  final String? description;
  final void Function()? ontap;
  const CustomProfileCard({
    required this.title,
    this.ontap,
    this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the current theme is dark or light
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Get screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Width and height based on screen size
    double containerWidth;
    double containerHeight;

    // Height
    if (screenHeight <= 600) {
      // Small screens
      containerHeight = context.dynamicHeight(0.053);
    } else if (screenHeight <= 800) {
      // Small screens
      containerHeight = context.dynamicHeight(0.053);
    } else if (screenHeight <= 900) {
      // Medium screens
      containerHeight = context.dynamicHeight(0.053);
    } else if (screenHeight <= 1080) {
      // Medium screens
      containerHeight = context.dynamicHeight(0.053);
    } else {
      // Large screens
      containerHeight = context.dynamicHeight(0.053);
    }

    // Width
    if (screenWidth <= 600) {
      // Very small screens
      containerWidth = context.dynamicWidth(0.88);
    } else if (screenWidth <= 800) {
      // Small screens
      containerWidth = context.dynamicWidth(0.77);
    } else if (screenWidth <= 900) {
      // Medium screens
      containerWidth = context.dynamicWidth(0.7);
    } else if (screenWidth <= 1080) {
      // Medium Large screens
      containerWidth = context.dynamicWidth(0.6);
    } else {
      // Large screens
      containerWidth = context.dynamicWidth(0.5);
    }

    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(context.lowRadius),
        color: AppLightColorConstants.contentTeritaryColor.withOpacity(0.09),
      ),
      child: Row(
        children: [
          Padding(
            padding: context.onlyLeftPaddingNormal,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: context.textStyleGrey(context).copyWith(
                      color: isDarkMode
                          ? ColorThemeUtil.getBgInverseColor(context)
                              .withOpacity(0.85)
                          : AppLightColorConstants.primaryColor,
                    ),
              ),
            ),
          ),
          const Spacer(),
          const Spacer(),
          // Description or Icon section
          description != null
              ? Flexible(
                  flex: 6, // This will allocate space for the description
                  child: Padding(
                    padding: context.onlyRightPaddingNormal,
                    child: Align(
                      alignment:
                          Alignment.centerRight, // Aligns the text to the right
                      child: Text(
                        description!,
                        style: context.textStyleGrey(context),
                        maxLines: 2, // Limit description to two lines
                        overflow:
                            TextOverflow.ellipsis, // Show "..." if it overflows
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: ontap,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
        ],
      ),
    );
  }
}
