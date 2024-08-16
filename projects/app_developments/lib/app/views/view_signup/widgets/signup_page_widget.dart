import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_signup/view_model/signup_event.dart';
import 'package:app_developments/app/views/view_signup/view_model/signup_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/constants/validation/sign_up_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SignupPageWidget extends StatelessWidget {
  const SignupPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BlocProvider.of<SignupViewModel>(context);

    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final maxHeight = constraints.maxHeight;

          // Determine height and width based on screen width
          double containerHeight;
          double googleContainerWidth;
          EdgeInsets leftPadding;

          // Height
          if (maxHeight <= 680) {
            // Small screens
            containerHeight = context.dynamicHeight(0.5);
          } else if (maxHeight <= 800) {
            // Small screens
            containerHeight = context.dynamicHeight(0.48);
          } else if (maxHeight <= 900) {
            // Medium screens
            containerHeight = context.dynamicHeight(0.435);
          } else if (maxHeight <= 1080) {
            // Medium screens
            containerHeight = context.dynamicHeight(0.4);
          } else {
            // Large screens
            containerHeight = context.dynamicHeight(0.43);
          }

          // Width
          if (maxWidth <= 600) {
            // very Small screens
            leftPadding = context.onlyLeftPaddingMedium;
            googleContainerWidth = context.dynamicWidth(0.65);
          } else if (maxWidth <= 800) {
            // Small screens
            leftPadding = context.onlyLeftPaddingMedium;
            googleContainerWidth = context.dynamicWidth(0.45);
          } else if (maxWidth <= 900) {
            // Medium screens
            leftPadding = context.onlyLeftPaddingMedium;
            googleContainerWidth = context.dynamicWidth(0.3);
          } else if (maxWidth <= 1080) {
            // Medium Large screens
            leftPadding = context.onlyLeftPaddingMedium;
            googleContainerWidth = context.dynamicWidth(0.3);
          } else {
            // Large screens
            leftPadding = context.onlyLeftPaddingHigh;
            googleContainerWidth = context.dynamicWidth(0.3);
          }

          return SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.sizedHeightBoxNormal,
                  SizedBox(
                    height: context.dynamicHeight(0.1),
                    width: context.dynamicWidth(1),
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
                                        color:
                                            AppLightColorConstants.primaryColor,
                                      ),
                                ),
                                TextSpan(
                                    text: 'Up',
                                    style: context.textStyleH2(context)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  context.sizedHeightBoxNormal,
                  Padding(
                    padding: leftPadding,
                    child: SizedBox(
                      height: containerHeight,
                      width: constraints
                          .maxWidth, // Use maxWidth for the container width
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email text
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Email',
                              style: context.textStyleGrey(context),
                            ),
                          ),
                          // Custom text field with hint text
                          CustomTextField(
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
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Password',
                              style: context.textStyleGrey(context),
                            ),
                          ),
                          // Custom text field with visibility toggle
                          CustomTextField(
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
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Confirm Password',
                              style: context.textStyleGrey(context),
                            ),
                          ),
                          // Custom text field with visibility toggle
                          CustomTextField(
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
                        }),
                  ),
                  context.sizedHeightBoxLow,
                  // Or
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: context.dynamicWidth(0.2),
                            right: context.dynamicWidth(0.06),
                          ),
                          child: const Divider(
                            color: AppLightColorConstants.contentDisabled,
                            height: 36,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'or',
                          style: context.textStyleGrey(context).copyWith(
                                fontSize: 20,
                                color: AppLightColorConstants.contentDisabled,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            left: context.dynamicWidth(0.06),
                            right: context.dynamicWidth(0.2),
                          ),
                          child: const Divider(
                            color: AppLightColorConstants.contentDisabled,
                            height: 36,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  context.sizedHeightBoxLow,
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: context.dynamicHeight(0.08),
                        width: googleContainerWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(context.normalRadius),
                          border: Border.all(
                            color: AppLightColorConstants.primaryColor,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.images.svg.google),
                            context.sizedWidthBoxLow,
                            Text(
                              'Sign Up With Google',
                              style: context
                                  .textStyleGreyBarlow(context)
                                  .copyWith(
                                      color:
                                          AppLightColorConstants.primaryColor,
                                      fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  context.sizedHeightBoxLow,
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              color:
                                  AppLightColorConstants.contentTeritaryColor,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Login',
                            style: context
                                .textStyleGreyBarlow(context)
                                .copyWith(
                                  color: AppLightColorConstants.primaryColor,
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
          );
        },
      ),
    );
  }
}
