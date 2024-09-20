import 'package:app_developments/app/views/view_settings/view_model/settings_event.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_state.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/constants/validation/feedback_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsFeedbackPageWidget extends StatelessWidget {
  const SettingsFeedbackPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsViewModel, SettingsState>(
      builder: (context, state) {
        // Check if the current theme is dark or light
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        // Get screen height and width using MediaQuery
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Tag square container
        double textfieldWidth;

        // Height
        if (screenHeight <= 600) {
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
          // Very small screens
          textfieldWidth = context.dynamicWidth(0.8);
        } else if (screenWidth <= 800) {
          // Small screens
          textfieldWidth = context.dynamicWidth(0.7);
        } else if (screenWidth <= 900) {
          // Medium screens
          textfieldWidth = context.dynamicWidth(0.7);
        } else if (screenWidth <= 1080) {
          // Medium Large screens
          textfieldWidth = context.dynamicWidth(0.6);
        } else {
          // Large screens
          textfieldWidth = context.dynamicWidth(0.55);
        }
        final viewModel = BlocProvider.of<SettingsViewModel>(context);
        return SingleChildScrollView(
          child: Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                BackButtonWithTitle(
                  title: 'Feedback',
                  ontap: () {
                    viewModel.add(
                      SettingsNavigateToNextPageEvent(
                          context: context, selectedPage: 1),
                    );
                  },
                ),
                SizedBox(
                  width: context.dynamicWidth(1),
                  height: context.dynamicHeight(0.13),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Help us improve by sharing your thoughts and suggestions.\nYour feedback is anonymous and greatly appreciated!',
                      textAlign: TextAlign.center,
                      style: context.textStyleGreyBarlow(context),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.dynamicWidth(1),
                  height: context.dynamicHeight(0.11),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Enter your feedback',
                      textAlign: TextAlign.center,
                      style: context.textStyleGreyBarlow(context).copyWith(
                            color: isDarkMode
                                ? AppLightColorConstants.bgLight
                                : AppLightColorConstants.primaryColor,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
                CustomTextField(
                  controller: viewModel.feedBackController,
                  textInputAction: TextInputAction.done,
                  outlineBorder: true,
                  width: textfieldWidth,
                  removePadding: true,
                  fillColor: AppLightColorConstants.infoColor,
                  hintText: 'Your feedback message',
                  validator: (value) => FeedbackValidation().checkValidMessage(
                    value,
                    context,
                  ),
                  isValid: (value) =>
                      FeedbackValidation().checkValidMessage(
                        value,
                        context,
                      ) ==
                      null,
                ),
                context.sizedHeightBoxMedium,
                context.sizedHeightBoxLower,
                CustomContinueButton(
                  buttonText: 'Submit',
                  onPressed: () {
                    if (viewModel.formKey.currentState!.validate()) {
                      context
                          .read<SettingsViewModel>()
                          .add(SettingsSubmitFeedbackEvent(context: context));
                      viewModel.add(
                        SettingsNavigateToNextPageEvent(
                          context: context,
                          selectedPage: 4,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
