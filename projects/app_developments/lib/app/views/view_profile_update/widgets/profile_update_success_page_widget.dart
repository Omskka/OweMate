import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_state.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_view_model.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ProfileUpdateSuccessPageWidget extends StatelessWidget {
  const ProfileUpdateSuccessPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileUpdateViewModel, ProfileUpdateState>(
      builder: (context, state) {
        // Check if the current theme is dark or light
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final viewModel = BlocProvider.of<ProfileUpdateViewModel>(context);
        return SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;

              EdgeInsets leftPadding;

              if (maxWidth <= 600) {
                leftPadding = context.onlyLeftPaddingMedium;
              } else if (maxWidth <= 800) {
                leftPadding = context.onlyLeftPaddingMedium;
              } else if (maxWidth <= 900) {
                leftPadding = context.onlyLeftPaddingMedium;
              } else if (maxWidth <= 1080) {
                leftPadding = context.onlyLeftPaddingHigh;
              } else {
                leftPadding = context.onlyLeftPaddingHigh;
              }

              return Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    context.sizedHeightBoxHigh,
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: context.dynamicHeight(0.4),
                            width: context.dynamicWidth(1),
                            child: Lottie.network(
                              'https://lottie.host/e57b82af-8aa9-4fd8-bd8a-0ff2e99088c8/pKhtuvLSJi.json',
                              repeat: false,
                              frameBuilder: (context, child, composition) {
                                if (composition == null) {
                                  return Container(
                                    height: context.dynamicHeight(0.4),
                                    width: context.dynamicWidth(1),
                                    color: Colors
                                        .transparent, // Empty container before loading
                                  );
                                } else {
                                  return child; // The Lottie animation
                                }
                              },
                            ),
                          ),
                          context.sizedHeightBoxLow,
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Sign Up Successful',
                              style: context.textStyleH1(context).copyWith(
                                    fontSize: 40,
                                    color: isDarkMode
                                        ? ColorThemeUtil.getBgInverseColor(
                                            context)
                                        : ColorThemeUtil.getPrimaryColor(
                                            context),
                                  ),
                            ),
                          ),
                          context.sizedHeightBoxMedium,
                          CustomContinueButton(
                            buttonText: 'Continue',
                            onPressed: () {
                              context.router.push(const LoginViewRoute());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
