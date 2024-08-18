import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_event.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_state.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/constants/validation/phone_number_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_rounded_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileUpdatePhonePageWidget extends StatelessWidget {
  const ProfileUpdatePhonePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileUpdateViewModel, ProfileUpdateState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<ProfileUpdateViewModel>(context);
        return SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;

              // Determine height and width based on screen width
              EdgeInsets leftPadding;
              // Print statements for debugging

              // Width
              if (maxWidth <= 600) {
                leftPadding = context.onlyLeftPaddingMedium;
                // very Small screens
              } else if (maxWidth <= 800) {
                // Small screens
                leftPadding = context.onlyLeftPaddingMedium;
              } else if (maxWidth <= 900) {
                // Medium screens
                leftPadding = context.onlyLeftPaddingMedium;
              } else if (maxWidth <= 1080) {
                // Medium Large screens
                leftPadding = context.onlyLeftPaddingHigh;
              } else {
                // Large screens
                leftPadding = context.onlyLeftPaddingHigh;
              }
              return Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: context.onlyTopPaddingMedium,
                      child: SizedBox(
                        height: context.dynamicHeight(0.1),
                        width: context.dynamicWidth(1),
                        child: Stack(
                          children: [
                            Positioned(
                              top: context.dynamicHeight(0.02),
                              left: context.dynamicWidth(0.05),
                              child: CustomRoundedButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  viewModel.add(ProfileUpdateSelectedPageEvent(
                                      context: context, selectedPage: 1));
                                },
                              ),
                            ),
                            Center(
                              child: Text(
                                'Phone Number',
                                style: context.textStyleH1(context).copyWith(
                                      fontSize: 20,
                                      color: AppLightColorConstants.bgInverse,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.1),
                      width: context.dynamicWidth(1),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Please add your\nphone number',
                          textAlign: TextAlign.center,
                          style: context.textStyleGrey(context).copyWith(
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ),
                    context.sizedHeightBoxMedium,
                    SizedBox(
                      height: context.dynamicHeight(0.25),
                      width: context.dynamicWidth(1),
                      child: Padding(
                        padding: leftPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: context.textStyleGrey(context),
                            ),
                            CustomTextField(
                              controller: viewModel.phoneNumberController,
                              textInputAction: TextInputAction.done,
                              hintText: '555 555 5555',
                              validator: (value) =>
                                  PhoneNumberValidation().validatePhoneNumber(
                                context,
                                value,
                                viewModel.phoneNumberController,
                              ),
                              isValid: (value) =>
                                  PhoneNumberValidation().validatePhoneNumber(
                                    context,
                                    value,
                                    viewModel.phoneNumberController,
                                  ) ==
                                  null,
                              keyboardType: TextInputType.phone,
                              prefixIcon: '+90',
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomContinueButton(
                      buttonText: 'Confirm',
                      onPressed: () {
                        // Check if textfiled inputs are valid
                        if (viewModel.formKey.currentState!.validate()) {
                          // If the form is valid, add user phone number
                          context.read<ProfileUpdateViewModel>().add(
                              ProfileUpdateAddPhoneNumberEvent(
                                  context: context));
                        }
                      },
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
