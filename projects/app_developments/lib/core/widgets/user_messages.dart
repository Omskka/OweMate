import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class UserMessages extends StatelessWidget {
  final String amount;
  final String date;
  final String status;

  const UserMessages({
    Key? key,
    required this.amount,
    required this.date,
    required this.status,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    // Get screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define responsive variables
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

      containerWidth = context.dynamicWidth(0.9);
    } else if (screenWidth <= 800) {
      // Small screens

      containerWidth = context.dynamicWidth(0.6);
    } else if (screenWidth <= 900) {
      // Medium screens

      containerWidth = context.dynamicWidth(0.55);
    } else if (screenWidth <= 1080) {
      // Medium Large screens

      containerWidth = context.dynamicWidth(0.45);
    } else {
      // Large screens

      containerWidth = context.dynamicWidth(0.4);
    }
    return Container(
      padding: EdgeInsets.all(context.lowValue),
      height: context.dynamicHeight(0.11),
      width: containerWidth,
      decoration: BoxDecoration(
        color: ColorThemeUtil.getMessageCardColor(context),
        borderRadius: BorderRadius.all(context.normalRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: context.onlyLeftPaddingNormal,
                child: Icon(
                  Icons.mail,
                  color: ColorThemeUtil.getPrimaryColor(context),
                  size: context.dynamicHeight(0.035),
                ),
              ),
              status == 'paid'
                  ? Padding(
                      padding: context.onlyLeftPaddingLow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Paid their debt',
                              style: context
                                  .textStyleTitleBarlow(context)
                                  .copyWith(
                                    fontSize: 18,
                                    color: AppLightColorConstants.successColor
                                        .withOpacity(0.75),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: context.onlyTopPaddingLow,
                            child: Text(
                              date,
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                  // Declined request
                  : status == 'declined'
                      ? Padding(
                          padding: context.onlyLeftPaddingLow,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Rejected Request',
                                  style: context
                                      .textStyleTitleBarlow(context)
                                      .copyWith(
                                          fontSize: 18,
                                          color: AppLightColorConstants
                                              .errorColor
                                              .withOpacity(0.8)),
                                ),
                              ),
                              Padding(
                                padding: context.onlyTopPaddingLow,
                                child: Text(
                                  date,
                                  style:
                                      context.textStyleGrey(context).copyWith(
                                            fontSize: 12,
                                          ),
                                ),
                              ),
                            ],
                          ),
                        )
                      // Paid debt
                      : Container(),
              Padding(
                padding: context.onlyRightPaddingNormal,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    amount,
                    style: context
                        .textStyleGrey(context)
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
