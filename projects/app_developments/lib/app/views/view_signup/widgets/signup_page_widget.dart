import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_signup/view_model/signup_event.dart';
import 'package:app_developments/app/views/view_signup/view_model/signup_view_model.dart';
import 'package:app_developments/core/constants/validation/sign_up_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPageWidget extends StatelessWidget {
  const SignupPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BlocProvider.of<SignupViewModel>(context);

    // Get screen height and width using MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine height and width based on screen dimensions
    double containerHeight;
    double textfieldWidth;
    EdgeInsets leftPadding;

    // Height
    if (screenHeight <= 680) {
      // Small screens
      containerHeight = screenHeight * 0.5;
    } else if (screenHeight <= 800) {
      // Small screens
      containerHeight = screenHeight * 0.48;
    } else if (screenHeight <= 900) {
      // Medium screens
      containerHeight = screenHeight * 0.435;
    } else if (screenHeight <= 1080) {
      // Medium screens
      containerHeight = screenHeight * 0.45;
    } else {
      // Large screens
      containerHeight = screenHeight * 0.38;
    }

    // Width
    if (screenWidth <= 600) {
      // very Small screens
      leftPadding = context.onlyLeftPaddingMedium;
      textfieldWidth = context.dynamicWidth(0.8);
    } else if (screenWidth <= 800) {
      // Small screens
      leftPadding = context.onlyLeftPaddingHigh;
      textfieldWidth = context.dynamicWidth(0.7);
    } else if (screenWidth <= 900) {
      // Medium screens
      leftPadding = context.onlyLeftPaddingHigh;
      textfieldWidth = context.dynamicWidth(0.7);
    } else if (screenWidth <= 1080) {
      // Medium Large screens
      leftPadding = EdgeInsets.symmetric(
          horizontal: (screenWidth - context.dynamicWidth(0.6)) / 2);
      textfieldWidth = context.dynamicWidth(0.6);
    } else {
      // Large screens
      leftPadding = EdgeInsets.symmetric(
          horizontal: (screenWidth - context.dynamicWidth(0.6)) / 2);
      textfieldWidth = context.dynamicWidth(0.6);
    }

    return SizedBox(
      height: screenHeight,
      child: PopScope(
        canPop: false,
        child: SingleChildScrollView(
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.sizedHeightBoxNormal,
                SizedBox(
                  height: screenHeight * 0.1,
                  width: screenWidth,
                  child: Padding(
                    padding: leftPadding,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sign ',
                                style: context.textStyleH2(context).copyWith(
                                      color: ColorThemeUtil.getPrimaryColor(
                                          context), // Get primary color based on theme
                                    ),
                              ),
                              TextSpan(
                                text: 'Up',
                                style: context.textStyleH2(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                context.sizedHeightBoxNormal,
                Center(
                  child: SizedBox(
                    height: containerHeight,
                    width:
                        textfieldWidth, // Use specific textfield width to center
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align contents inside the column to start
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Email text
                        Text(
                          'Email',
                          style: context.textStyleGrey(context),
                        ),
                        // Custom text field with hint text
                        CustomTextField(
                          width: textfieldWidth,
                          textInputAction: TextInputAction.next,
                          hintText: 'JohnDoe@gmail.com',
                          validator: (value) =>
                              SignUpValidation().checkMailErrors(
                            value,
                            context,
                            viewModel.emailController,
                          ),
                          showVisibilityToggle: false,
                          isValid: (value) =>
                              SignUpValidation().checkMailErrors(
                                value,
                                context,
                                viewModel.emailController,
                              ) ==
                              null,
                          keyboardType: TextInputType.emailAddress,
                          controller: viewModel.emailController,
                        ),
                        context.sizedHeightBoxMedium,
                        // Password text
                        Text(
                          'Password',
                          style: context.textStyleGrey(context),
                        ),
                        // Custom text field with visibility toggle
                        CustomTextField(
                          width: textfieldWidth,
                          hintText: '',
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              SignUpValidation().checkPasswordErrors(
                            value,
                            context,
                            viewModel.passwordController,
                          ),
                          showVisibilityToggle: true,
                          controller: viewModel.passwordController,
                        ),
                        context.sizedHeightBoxMedium,
                        // Confirm password text
                        Text(
                          'Confirm Password',
                          style: context.textStyleGrey(context),
                        ),
                        // Custom text field with visibility toggle
                        CustomTextField(
                          width: textfieldWidth,
                          hintText: '',
                          textInputAction: TextInputAction.done,
                          validator: (value) =>
                              SignUpValidation().checkConfirmPasswordErrors(
                            value,
                            context,
                            viewModel.passwordController,
                            viewModel.confirmPasswordController,
                          ),
                          showVisibilityToggle: true,
                          controller: viewModel.confirmPasswordController,
                        ),
                      ],
                    ),
                  ),
                ),

                context.sizedHeightBoxNormal,
                // Sign up button
                Center(
                  child: CustomContinueButton(
                    buttonText: 'Sign Up',
                    onPressed: () {
                      if (viewModel.formKey.currentState!.validate()) {
                        // If the form is valid sign up new user
                        context.read<SignupViewModel>().add(
                              SignupUserEvent(context: context),
                            );
                      }
                    },
                  ),
                ),
                context.sizedHeightBoxHigh,
                context.sizedHeightBoxMedium,
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: DefaultTextStyle.of(context).style.copyWith(
                            color:
                                ColorThemeUtil.getContentTeritaryColor(context),
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
                          style: context.textStyleGreyBarlow(context).copyWith(
                                color: ColorThemeUtil.getPrimaryColor(context),
                                fontSize: 16,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Route to LoginViewRoute on tap
                              context.router.push(const LoginViewRoute());
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
