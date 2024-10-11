import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_event.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_state.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/settings_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPageWidget extends StatelessWidget {
  const SettingsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsViewModel, SettingsState>(
      builder: (context, state) {
        // Check if the current theme is dark or light
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        final viewModel = BlocProvider.of<SettingsViewModel>(context);
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
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Aligns everything to the start
            children: [
              BackButtonWithTitle(
                title: 'Settings',
                ontap: () {
                  context.router.push(const HomeViewRoute());
                },
              ),
              context.sizedHeightBoxLower,
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.dynamicHeight(0.04),
                      child: Text(
                        'Appearance',
                        style: context.textStyleGreyBarlow(context).copyWith(
                              color: isDarkMode
                                  ? ColorThemeUtil.getBgInverseColor(context)
                                  : AppLightColorConstants.primaryColor,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    SettingsCard(
                      // Remove the Center widget wrapping this
                      title: 'Dark Mode',
                      description: 'Enable or disable dark mode',
                      showSwitch: true,
                      switchValue: state
                          .isDarkTheme, // Pass the current state of the switch
                      onSwitchChanged: (bool value) {
                        context.read<SettingsViewModel>().add(
                              SettingsSwitchEvent(
                                context: context,
                                eventType: 'Appearance',
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
              context.sizedHeightBoxLow,
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.dynamicHeight(0.04),
                      child: Text(
                        'Order',
                        style: context.textStyleGreyBarlow(context).copyWith(
                              color: isDarkMode
                                  ? ColorThemeUtil.getBgInverseColor(context)
                                  : AppLightColorConstants.primaryColor,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    SettingsCard(
                      // Remove the Center widget wrapping this
                      title: 'Reverse Order',
                      description: 'Oldest events will be shown at the top',
                      showSwitch: true,
                      switchValue: state
                          .isOrderReversed, // Pass the current state of the switch
                      onSwitchChanged: (bool value) {
                        context.read<SettingsViewModel>().add(
                              SettingsSwitchEvent(
                                context: context,
                                eventType: 'order',
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
              context.sizedHeightBoxLow,
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.dynamicHeight(0.04),
                      child: Text(
                        'Feedback',
                        style: context.textStyleGreyBarlow(context).copyWith(
                              color: isDarkMode
                                  ? ColorThemeUtil.getBgInverseColor(context)
                                  : AppLightColorConstants.primaryColor,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    SettingsCard(
                      // Remove the Center widget wrapping this
                      title: 'User Feedback',
                      description: 'Share your experience to help us improve',
                      onPressed: () {
                        viewModel.add(
                          SettingsNavigateToNextPageEvent(
                              context: context, selectedPage: 3),
                        );
                      },
                    ),
                  ],
                ),
              ),
              context.sizedHeightBoxLow,
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.dynamicHeight(0.04),
                      child: Text(
                        'Account',
                        style: context.textStyleGreyBarlow(context).copyWith(
                              color: isDarkMode
                                  ? ColorThemeUtil.getBgInverseColor(context)
                                  : AppLightColorConstants.primaryColor,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get the current user's UID
                        context.read<SettingsViewModel>().add(
                              SettingsSignOutEvent(context: context),
                            );
                      },
                      child: Container(
                          padding: context.paddingNormal,
                          width: context.dynamicWidth(containerWidth),
                          height: context.dynamicHeight(0.085),
                          decoration: BoxDecoration(
                            color: ColorThemeUtil.getFinanceCardColor(context),
                            borderRadius:
                                BorderRadius.all(context.normalRadius),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: context.onlyRightPaddingNormal,
                                child: const Icon(
                                  Icons.logout,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Sign Out',
                                  style: context
                                      .textStyleTitleBarlow(context)
                                      .copyWith(
                                        color: ColorThemeUtil
                                            .getContentTeritaryColor(context),
                                        fontSize: 19,
                                      ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    context.sizedHeightBoxLow,
                    GestureDetector(
                      onTap: () {
                        // Show a confirmation dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                'Are you sure you want to delete your account? This action is irreversible.',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    // If confirmed, proceed with account deletion
                                    context.read<SettingsViewModel>().add(
                                          SettingsDeleteAccountEvent(
                                              context: context),
                                        );
                                    // Close the dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: AppLightColorConstants.errorColor,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Dismiss the dialog if user cancels
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: ColorThemeUtil.getPrimaryColor(
                                            context)),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: context.paddingNormal,
                        width: context.dynamicWidth(containerWidth),
                        height: context.dynamicHeight(0.085),
                        decoration: BoxDecoration(
                          color: ColorThemeUtil.getFinanceCardColor(context),
                          borderRadius: BorderRadius.all(context.normalRadius),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Delete Account',
                            style: context
                                .textStyleTitleBarlow(context)
                                .copyWith(
                                  color: ColorThemeUtil.getContentTeritaryColor(
                                      context),
                                  fontSize: 19,
                                ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              context.sizedHeightBoxNormal,
            ],
          ),
        );
      },
    );
  }
}
