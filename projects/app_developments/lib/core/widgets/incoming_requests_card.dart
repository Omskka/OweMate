import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class IncomingRequestsCard extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String date;
  final String amount;
  final VoidCallback onMarkAsPaid;
  final VoidCallback onDeclineRequest;

  const IncomingRequestsCard({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.date,
    required this.amount,
    required this.onMarkAsPaid,
    required this.onDeclineRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.lowValue),
      height: context.dynamicHeight(0.15),
      width: context.dynamicWidth(0.75),
      decoration: BoxDecoration(
        color: ColorThemeUtil.getDrawerColor(context),
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
                  padding: context.onlyLeftPaddingMedium,
                  child: CircleAvatar(
                    radius: context.dynamicHeight(0.03),
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                ),
                SizedBox(width: context.lowValue),
                Expanded(
                  child: Padding(
                    padding: context.onlyLeftPaddingLow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            name,
                            style: context.textStyleGrey(context).copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
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
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: onDeclineRequest,
                icon: const Icon(Icons.cancel,
                    color: AppLightColorConstants.errorColor),
                label: Text(
                  'Decline',
                  style: context.textStyleGrey(context).copyWith(
                        color: AppLightColorConstants.errorColor,
                      ),
                ),
              ),
              TextButton.icon(
                onPressed: onMarkAsPaid,
                icon: const Icon(Icons.check_circle,
                    color: AppLightColorConstants.successColor),
                label: Text(
                  'Mark as Paid',
                  style: context.textStyleGrey(context).copyWith(
                        color: AppLightColorConstants.successColor,
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
