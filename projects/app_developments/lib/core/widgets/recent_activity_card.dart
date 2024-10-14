import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class RecentActivityCard extends StatelessWidget {
  final String profileImageUrl;
  final String friendName;
  final String amount;
  final String date;
  final String status;
  final bool request;

  const RecentActivityCard({
    Key? key,
    required this.profileImageUrl,
    required this.friendName,
    required this.amount,
    required this.date,
    required this.status,
    required this.request,
  }) : super(
          key: key,
        );

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
      containerWidth = context.dynamicWidth(0.9);
    } else if (screenWidth <= 800) {
      // Small screens
      circleAvatarWidth = 0.05;
      containerWidth = context.dynamicWidth(0.6);
    } else if (screenWidth <= 900) {
      // Medium screens
      circleAvatarWidth = 0.04;
      containerWidth = context.dynamicWidth(0.55);
    } else if (screenWidth <= 1080) {
      // Medium Large screens
      circleAvatarWidth = 0.036;
      containerWidth = context.dynamicWidth(0.45);
    } else {
      // Large screens
      circleAvatarWidth = 0.02;
      containerWidth = context.dynamicWidth(0.4);
    }

    // Get font size
    double textScaleFactor = MediaQuery.textScalerOf(context).scale(1);

    // Contianer Height
    double containerHeight;

    if (textScaleFactor <= 1) {
      containerHeight = context.dynamicHeight(0.12);
    } else if (textScaleFactor <= 1.15) {
      containerHeight = context.dynamicHeight(0.13);
    } else if (textScaleFactor <= 1.3) {
      containerHeight = context.dynamicHeight(0.14);
    } else {
      containerHeight = context.dynamicHeight(0.15);
    }
    return Container(
      padding: EdgeInsets.all(context.lowValue),
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: ColorThemeUtil.getDrawerColor(context),
        borderRadius: BorderRadius.all(context.normalRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.onlyTopPaddingLow,
            child: Row(
              children: [
                Padding(
                  padding: context.onlyLeftPaddingLow,
                  child: CircleAvatar(
                    radius: context.dynamicHeight(0.03),
                    backgroundImage: isValidImageUrl(profileImageUrl)
                        ? NetworkImage(profileImageUrl)
                        : null, // Only load if valid
                    backgroundColor: Colors.grey[
                        300], // Placeholder color if image is not available
                  ),
                ),
                SizedBox(width: context.lowValue),
                Expanded(
                  // Paid request
                  child: request && status == 'paid'
                      ? Padding(
                          padding: context.onlyLeftPaddingLow,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friendName,
                                style: context.textStyleGrey(context).copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                              ),
                              Text(
                                'Paid their debt',
                                style: context.textStyleGrey(context).copyWith(
                                    fontSize: 13,
                                    color: AppLightColorConstants.successColor
                                        .withOpacity(0.8)),
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
                      // Declined request
                      : request && status == 'declined'
                          ? Padding(
                              padding: context.onlyLeftPaddingLow,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      friendName,
                                      style: context
                                          .textStyleGrey(context)
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Rejected Request',
                                      style: context
                                          .textStyleGrey(context)
                                          .copyWith(
                                              fontSize: 13,
                                              color: AppLightColorConstants
                                                  .errorColor
                                                  .withOpacity(0.8)),
                                    ),
                                  ),
                                  Padding(
                                    padding: context.onlyTopPaddingLow,
                                    child: Text(
                                      date,
                                      style: context
                                          .textStyleGrey(context)
                                          .copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          // Paid debt
                          : status == 'paid' && !request
                              ? Padding(
                                  padding: context.onlyLeftPaddingLow,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'You paid',
                                          style: context
                                              .textStyleGrey(context)
                                              .copyWith(
                                                fontSize: 13,
                                                color: AppLightColorConstants
                                                    .successColor
                                                    .withOpacity(0.8),
                                              ),
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          friendName,
                                          style: context
                                              .textStyleGrey(context)
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: context.onlyTopPaddingLow,
                                        child: Text(
                                          date,
                                          style: context
                                              .textStyleGrey(context)
                                              .copyWith(
                                                fontSize: 12,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : status == 'declined' && !request
                                  ? Padding(
                                      padding: context.onlyLeftPaddingLow,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'You Rejected',
                                              style: context
                                                  .textStyleGrey(context)
                                                  .copyWith(
                                                    fontSize: 13,
                                                    color:
                                                        AppLightColorConstants
                                                            .errorColor
                                                            .withOpacity(0.8),
                                                  ),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              friendName,
                                              style: context
                                                  .textStyleGrey(context)
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: context.onlyTopPaddingLow,
                                            child: Text(
                                              date,
                                              style: context
                                                  .textStyleGrey(context)
                                                  .copyWith(
                                                    fontSize: 12,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                ),
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
          ),
        ],
      ),
    );
  }
}

bool isValidImageUrl(String url) {
  return url.isNotEmpty &&
      (url.startsWith('http://') || url.startsWith('https://'));
}
