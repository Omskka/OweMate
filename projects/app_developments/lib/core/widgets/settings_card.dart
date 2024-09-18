import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final String description;
  final bool showSwitch;
  final VoidCallback? onPressed;

  final bool? switchValue; // Add this to track the switch state
  final List<String>? panelItems; // Items for the selection panel
  final ValueChanged<bool>? onSwitchChanged; // Callback for the switch

  const SettingsCard({
    required this.title,
    required this.description,
    this.showSwitch = false,
    this.onPressed,
    this.switchValue, // Make this required
    this.panelItems,
    this.onSwitchChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = (screenWidth <= 600)
        ? 0.85
        : (screenWidth <= 800)
            ? 0.75
            : (screenWidth <= 900)
                ? 0.65
                : (screenWidth <= 1080)
                    ? 0.55
                    : 0.45;

    return Container(
      padding: context.paddingNormal,
      width: context.dynamicWidth(containerWidth),
      height: context.dynamicHeight(0.1),
      decoration: BoxDecoration(
        color: AppLightColorConstants.infoColor,
        borderRadius: BorderRadius.all(context.normalRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title and description
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: context.textStyleGreyBarlow(context),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  description,
                  style: context.textStyleGrey(context),
                ),
              )
            ],
          ),

          // Switch (if showSwitch is true)
          showSwitch
              ? Switch(
                  activeColor: AppLightColorConstants.primaryColor,
                  inactiveThumbColor: AppLightColorConstants.infoColor,
                  inactiveTrackColor:
                      AppLightColorConstants.contentTeritaryColor,
                  value: switchValue!, // Use the switchValue variable here
                  onChanged: (bool value) {
                    if (onSwitchChanged != null) {
                      onSwitchChanged!(
                          value); // Trigger callback when switch is changed
                    }
                  },
                )
              : GestureDetector(
                  onTap: onPressed,
                  child: const Icon(Icons.arrow_forward_ios),
                )
        ],
      ),
    );
  }
}
