import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_login/view_model/login_event.dart';
import 'package:app_developments/app/views/view_login/view_model/login_state.dart';
import 'package:app_developments/app/views/view_login/view_model/login_view_model.dart';
import 'package:app_developments/core/constants/validation/sign_up_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginResetPasswordPageWidget extends StatelessWidget {
  const LoginResetPasswordPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BlocProvider.of<LoginViewModel>(context);

    return PopScope(
      canPop: true,
      child: BlocBuilder<LoginViewModel, LoginState>(
        builder: (context, state) {
          final maxWidth = MediaQuery.of(context).size.width;

          // Determine height and width based on screen width
          double textfieldWidth;

          // Width
          if (maxWidth <= 600) {
            // very Small screens
            textfieldWidth = context.dynamicWidth(0.8);
          } else if (maxWidth <= 800) {
            // Small screens

            textfieldWidth = context.dynamicWidth(0.7);
          } else if (maxWidth <= 900) {
            // Medium screens

            textfieldWidth = context.dynamicWidth(0.7);
          } else if (maxWidth <= 1080) {
            // Medium Large screens

            textfieldWidth = context.dynamicWidth(0.6);
          } else {
            // Large screens

            textfieldWidth = context.dynamicWidth(0.6);
          }

          return SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  BackButtonWithTitle(
                    title: 'Reset Password',
                    ontap: () {
                      viewModel.add(
                        LoginNavigateToNextPageEvent(
                            context: context, selectedPage: 1),
                      );
                    },
                  ),
                  SizedBox(
                    //color: Colors.amber,
                    width: context.dynamicWidth(1),
                    height: context.dynamicHeight(0.7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Enter your email and we will send\nyou a password reset link.',
                            textAlign: TextAlign.center,
                            style: context.textStyleTitleBarlow(context),
                          ),
                        ),
                        context.sizedHeightBoxNormal,
                        CustomTextField(
                          width: textfieldWidth,
                          controller: viewModel.resetEmailController,
                          removePadding: true,
                          outlineBorder: true,
                          fillColor:
                              ColorThemeUtil.getFinanceCardColor(context),
                          textInputAction: TextInputAction.done,
                          hintText: 'JohnDoe@gmail.com',
                          validator: (value) =>
                              SignUpValidation().checkMailErrors(
                            value,
                            context,
                            viewModel.resetEmailController,
                          ),
                          isValid: (value) =>
                              SignUpValidation().checkMailErrors(
                                value,
                                context,
                                viewModel.resetEmailController,
                              ) ==
                              null,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        context.sizedHeightBoxMedium,
                        CustomContinueButton(
                          buttonText: 'Reset Password',
                          onPressed: () {
                            if (viewModel.formKey.currentState!.validate()) {
                              // If the form is valid sign In user
                              if (viewModel.formKey.currentState!.validate()) {
                                context.read<LoginViewModel>().add(
                                    LoginSendResetCodeEvent(context: context));
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
