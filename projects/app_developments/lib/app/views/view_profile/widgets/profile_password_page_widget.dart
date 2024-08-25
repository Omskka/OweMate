import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_event.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_state.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/constants/validation/sign_up_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_rounded_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:auto_route/auto_route.dart';
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
        return Scaffold(
          backgroundColor: AppLightColorConstants.bgLight,
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
                    padding: context.onlyLeftPaddingMedium,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: context.onlyLeftPaddingLow,
                            child: Text(
                              'Enter Old Password',
                              style: context.textStyleGrey(context),
                            )),
                        context.sizedHeightBoxLower,
                        CustomTextField(
                          fillColor: AppLightColorConstants.infoColor,
                          outlineBorder: true,
                          removePadding: true,
                          controller: viewModel.oldPasswordController,
                          showVisibilityToggle: true,
                          textInputAction: TextInputAction.next,
                        ),
                        context.sizedHeightBoxNormal,
                        Padding(
                            padding: context.onlyLeftPaddingLow,
                            child: Text(
                              'Re-Enter New Password',
                              style: context.textStyleGrey(context),
                            )),
                        context.sizedHeightBoxLower,
                        CustomTextField(
                          fillColor: AppLightColorConstants.infoColor,
                          outlineBorder: true,
                          removePadding: true,
                          controller: viewModel.newPasswordController,
                          validator: (value) => SignUpValidation()
                              .checkPasswordErrors(value, context,
                                  viewModel.newPasswordController),
                          showVisibilityToggle: true,
                          textInputAction: TextInputAction.next,
                        ),
                        context.sizedHeightBoxNormal,
                        Padding(
                          padding: context.onlyLeftPaddingLow,
                          child: Text(
                            'Enter Old Password',
                            style: context.textStyleGrey(context),
                          ),
                        ),
                        context.sizedHeightBoxLower,
                        CustomTextField(
                          fillColor: AppLightColorConstants.infoColor,
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
