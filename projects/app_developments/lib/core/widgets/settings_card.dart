import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/constants/dark_theme_color_constants.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final String description;
  final bool showSwitch;
  final VoidCallback? onPressed;
  final bool? switchValue; // Add this to track the switch state
  final ValueChanged<bool>? onSwitchChanged; // Callback for the switch

  const SettingsCard({
    required this.title,
    required this.description,
    this.showSwitch = false,
    this.onPressed,
    this.switchValue,
    this.onSwitchChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = (screenWidth <= 600)
        ? 0.9
        : (screenWidth <= 800)
            ? 0.8
            : (screenWidth <= 900)
                ? 0.7
                : (screenWidth <= 1080)
                    ? 0.6
                    : 0.5;

    return Container(
      padding: context.paddingNormal,
      width: context.dynamicWidth(containerWidth),
      height: context.dynamicHeight(0.1),
      decoration: BoxDecoration(
        color: ColorThemeUtil.getFinanceCardColor(context),
        borderRadius: BorderRadius.all(context.normalRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title and description
          Expanded(
            // Use Expanded to allow flexible sizing
            child: Padding(
              padding: context.onlyLeftPaddingLow,
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the items vertically
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: context.textStyleGreyBarlow(context),
                      maxLines: 1, // Limit title to 1 line
                      overflow:
                          TextOverflow.ellipsis, // Ensure ellipsis for overflow
                    ),
                  ),
                  Flexible(
                    child: Text(
                      description,
                      style: context.textStyleGrey(context),
                      maxLines: 1, // Limit description to 1 line
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Switch (if showSwitch is true)
          if (showSwitch)
            SizedBox(
              width: 40, // Set a fixed width for the switch
              child: Switch(
                activeColor: AppDarkColorConstants.moneyCardColor,
                activeTrackColor: AppDarkColorConstants.contentTeritaryColor,
                inactiveThumbColor: AppLightColorConstants.infoColor,
                inactiveTrackColor: AppLightColorConstants.contentTeritaryColor,
                value: switchValue!, // Use the switchValue variable here
                onChanged: (bool value) {
                  if (onSwitchChanged != null) {
                    onSwitchChanged!(
                        value); // Trigger callback when switch is changed
                  }
                },
              ),
            )
          else
            GestureDetector(
              onTap: onPressed,
              child: const SizedBox(
                width: 30, // Set a fixed size for the icon
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
