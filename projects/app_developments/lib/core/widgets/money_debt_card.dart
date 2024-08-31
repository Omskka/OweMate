import 'package:flutter/material.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';

class MoneyDebtCard extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String amount;
  final String date;
  const MoneyDebtCard({
    required this.profileImageUrl,
    required this.name,
    required this.amount,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.onlyRightPaddingNormal,
      child: Container(
        height: context.dynamicHeight(0.25),
        width: context.dynamicWidth(0.45),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(context.normalRadius),
          color: AppLightColorConstants.bgLight,
        ),
        child: Padding(
          padding: context.paddingLow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: context.dynamicWidth(0.09),
                backgroundColor: AppLightColorConstants.infoColor,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              SizedBox(height: context.dynamicHeight(0.02)),
              Center(
                child: RichText(
                  textAlign:
                      TextAlign.center, // Align text within the RichText widget
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Request From\n',
                        style: context.textStyleGrey(context),
                      ),
                      TextSpan(
                        text: name,
                        style: context.textStyleGreyBarlow(context),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              Text(
                amount,
                style: context
                    .textStyleGreyBarlow(context)
                    .copyWith(color: AppLightColorConstants.thirdColor),
              ),
              SizedBox(
                  height: context.dynamicHeight(
                0.01,
              )),
              Text(
                date,
                style: context.textStyleGrey(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
