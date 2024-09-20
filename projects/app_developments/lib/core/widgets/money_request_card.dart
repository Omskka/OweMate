import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:flutter/material.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';

class MoneyRequestCard extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String amount;
  final String date;

  const MoneyRequestCard({
    required this.profileImageUrl,
    required this.name,
    required this.amount,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define responsive variables
    double circleAvatarWidth;
    double containerWidth;

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
      circleAvatarWidth = 0.09;
      containerWidth = 0.45;
    } else if (screenWidth <= 800) {
      // Small screens
      circleAvatarWidth = 0.05;
      containerWidth = 0.4;
    } else if (screenWidth <= 900) {
      // Medium screens
      circleAvatarWidth = 0.04;
      containerWidth = 0.4;
    } else if (screenWidth <= 1080) {
      // Medium Large screens
      circleAvatarWidth = 0.036;
      containerWidth = 0.3;
    } else {
      // Large screens
      circleAvatarWidth = 0.02;
      containerWidth = 0.2;
    }

    return Padding(
      padding: context.onlyRightPaddingNormal,
      child: Container(
        height: context.dynamicHeight(0.25),
        width: context.dynamicWidth(containerWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(context.normalRadius),
          color: ColorThemeUtil.getMoneyCardColor(context),
        ),
        child: Padding(
          padding: context.paddingLow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: context.dynamicWidth(circleAvatarWidth),
                backgroundColor: profileImageUrl.isEmpty
                    ? AppLightColorConstants.infoColor
                    : Colors.transparent,
                backgroundImage: profileImageUrl.isNotEmpty
                    ? NetworkImage(profileImageUrl)
                    : null,
                child: profileImageUrl.isEmpty
                    ? const Icon(Icons.person, color: Colors.blue)
                    : null,
              ),
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Sent Request to\n',
                          style: context.textStyleGrey(context),
                        ),
                        TextSpan(
                          text: name,
                          style: context.textStyleGreyBarlow(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  amount,
                  style: context.textStyleGreyBarlow(context).copyWith(
                        color: ColorThemeUtil.getMoneyDebtAmountColor(
                          context,
                        ),
                      ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  date,
                  style: context.textStyleGrey(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
