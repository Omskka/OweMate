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
            child: Text(
              title,
              style: context.textStyleGrey(context).copyWith(
                    color: AppLightColorConstants.primaryColor,
                  ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: context.onlyRightPaddingNormal,
            child: description != null
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      description!,
                      style: context.textStyleGrey(context),
                    ),
                  )
                : GestureDetector(
                    onTap: ontap,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    )),
          )
        ],
      ),
    );
  }
}
