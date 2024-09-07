import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class RecentActivityCard extends StatelessWidget {
  final String profileImageUrl;
  final String friendName;
  final String amount;
  final String date;

  const RecentActivityCard({
    Key? key,
    required this.profileImageUrl,
    required this.friendName,
    required this.amount,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.lowValue),
      height: context.dynamicHeight(0.11),
      width:
          context.dynamicWidth(0.9), // Example width, you might need to adjust
      decoration: BoxDecoration(
        color: AppLightColorConstants.infoColor,
        borderRadius: BorderRadius.all(context.normalRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.onlyTopPaddingLow * 1.5,
            child: Row(
              children: [
                Padding(
                  padding: context.onlyLeftPaddingLow,
                  child: CircleAvatar(
                    radius: context.dynamicHeight(0.03),
                    backgroundImage: NetworkImage(profileImageUrl),
                    backgroundColor: Colors.grey[
                        300], // Placeholder color if image is not available
                  ),
                ),
                SizedBox(width: context.lowValue),
                Expanded(
                  child: Padding(
                    padding: context.onlyLeftPaddingLow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          friendName,
                          style: context.textStyleGrey(context).copyWith(
                              fontWeight: FontWeight.bold, fontSize: 16),
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
                  ),
                ),
                Padding(
                  padding: context.onlyRightPaddingMedium,
                  child: Text(
                    amount,
                    style: context
                        .textStyleGrey(context)
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
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
