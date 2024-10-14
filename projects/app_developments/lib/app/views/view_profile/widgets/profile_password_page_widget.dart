import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_event.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_state.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_view_model.dart';
import 'package:app_developments/core/constants/validation/sign_up_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePasswordPageWidget extends StatelessWidget {
  const ProfilePasswordPageWidget({
    required this.state,
    super.key,
  });
  final ProfileState state;
  @override
  Widget build(BuildContext context) {
    final viewModel = BlocProvider.of<ProfileViewModel>(context);
    return BlocBuilder<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        // Get screen height and width using MediaQuery
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Tag square container
        double textfieldWidth;

        //  left padding
        EdgeInsets leftPadding;

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
          leftPadding = leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.8)) / 2);
        } else if (screenWidth <= 800) {
          // Small screens
          textfieldWidth = context.dynamicWidth(0.7);
          leftPadding = leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.7)) / 2);
        } else if (screenWidth <= 900) {
          // Medium screens
          textfieldWidth = context.dynamicWidth(0.7);
          leftPadding = leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.7)) / 2);
        } else if (screenWidth <= 1080) {
          // Medium Large screens
          textfieldWidth = context.dynamicWidth(0.6);
          leftPadding = leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.6)) / 2);
        } else {
          // Large screens
          textfieldWidth = context.dynamicWidth(0.55);
          leftPadding = leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.6)) / 2);
        }
        return Scaffold(
          backgroundColor: ColorThemeUtil.getBgLightColor(context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BackButtonWithTitle(
                    title: 'Change password',
                    ontap: () {
                      viewModel.add(
                        ProfileSelectedPageEvent(selectedPage: 1),
                      );
                    }),
                SizedBox(
                  height: context.dynamicHeight(0.08),
                  width: context.dynamicWidth(1),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Enter a new password below to\nchange your password.',
                      style:
                          context.textStyleGrey(context).copyWith(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                context.sizedHeightBoxMedium,
                SizedBox(
                  height: context.dynamicHeight(0.45),
                  width: context.dynamicWidth(1),
                  child: Padding(
                    padding: leftPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: context.onlyLeftPaddingLow,
                          child: Text(
                            'Enter Old Password',
                            style: context.textStyleGrey(context),
                          ),
                        ),
                        context.sizedHeightBoxLower,
                        CustomTextField(
                          width: textfieldWidth,
                          fillColor:
                              ColorThemeUtil.getFinanceCardColor(context),
                          outlineBorder: true,
                          removePadding: true,
                          controller: viewModel.oldPasswordController,
                          showVisibilityToggle: true,
                          textInputAction: TextInputAction.next,
                        ),
                        context.sizedHeightBoxLower,
                        Padding(
                            padding: context.onlyLeftPaddingLow,
                            child: Text(
                              'Enter New Password',
                              style: context.textStyleGrey(context),
                            )),
                        context.sizedHeightBoxLower,
                        CustomTextField(
                          width: textfieldWidth,
                          fillColor:
                              ColorThemeUtil.getFinanceCardColor(context),
                          outlineBorder: true,
                          removePadding: true,
                          controller: viewModel.newPasswordController,
                          validator: (value) => SignUpValidation()
                              .checkPasswordErrors(value, context,
                                  viewModel.newPasswordController),
                          showVisibilityToggle: true,
                          textInputAction: TextInputAction.next,
                        ),
                        context.sizedHeightBoxLower,
                        Padding(
                          padding: context.onlyLeftPaddingLow,
                          child: Text(
                            'Re-Enter New Password',
                            style: context.textStyleGrey(context),
                          ),
                        ),
                        context.sizedHeightBoxLower,
                        CustomTextField(
                          width: textfieldWidth,
                          fillColor:
                              ColorThemeUtil.getFinanceCardColor(context),
                          outlineBorder: true,
                          removePadding: true,
                          controller: viewModel.newConfirmPasswordController,
                          validator: (value) =>
                              SignUpValidation().checkConfirmPasswordErrors(
                            value,
                            context,
                            viewModel.newPasswordController,
                            viewModel.newConfirmPasswordController,
                          ),
                          showVisibilityToggle: true,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                ),
                context.sizedHeightBoxLower,
                CustomContinueButton(
                  buttonText: 'Confirm',
                  borderRadius: BorderRadius.all(context.normalRadius),
                  onPressed: () {
                    context.read<ProfileViewModel>().add(
                          ProfileChangePasswordEvent(context: context),
                        );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
