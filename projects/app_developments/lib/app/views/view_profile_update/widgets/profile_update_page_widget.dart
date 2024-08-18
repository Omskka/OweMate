import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_event.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_state.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/constants/validation/profile_update_validation.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/core/widgets/custom_rounded_button.dart';
import 'package:app_developments/core/widgets/custom_text_field.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileUpdatePageWidget extends StatelessWidget {
  const ProfileUpdatePageWidget({super.key});

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
              double containerWidth;

              EdgeInsets leftPadding;

              // Width
              if (maxWidth <= 600) {
                leftPadding = context.onlyLeftPaddingMedium;
                containerWidth = context.dynamicWidth(0.6);

                // very Small screens
              } else if (maxWidth <= 800) {
                // Small screens
                leftPadding = context.onlyLeftPaddingMedium;
                containerWidth = context.dynamicWidth(0.5);
              } else if (maxWidth <= 900) {
                // Medium screens
                leftPadding = context.onlyLeftPaddingMedium;
                containerWidth = context.dynamicWidth(0.4);
              } else if (maxWidth <= 1080) {
                // Medium Large screens
                leftPadding = context.onlyLeftPaddingHigh;
                containerWidth = context.dynamicWidth(0.3);
              } else {
                // Large screens
                leftPadding = context.onlyLeftPaddingHigh;
                containerWidth = context.dynamicWidth(0.2);
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
                                  context.router.push(const SignupViewRoute());
                                },
                              ),
                            ),
                            Center(
                              child: Text(
                                'Set Profile',
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
                      height: context.dynamicHeight(0.05),
                      width: context.dynamicWidth(1),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Please set up your profile',
                          style: context.textStyleGrey(context).copyWith(
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.25),
                      width: context.dynamicWidth(1),
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              child: SvgPicture.asset(
                                Assets.images.svg.profileCircle,
                                width: context.dynamicWidth(0.17),
                                height: context.dynamicHeight(0.17),
                              ),
                            ),
                            Positioned(
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<ProfileUpdateViewModel>(
                                          context)
                                      .add(ProfileUpdateSelectImageEvent(
                                          context: context));
                                },
                                // Display icon if selectedImage is null
                                child: viewModel.selectedImage == null
                                    ? const Icon(
                                        Icons.file_upload_outlined,
                                        color: AppLightColorConstants.bgLight,
                                        size: 30,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            // if
                            if (viewModel.selectedImage != null)
                              Positioned(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    viewModel.selectedImage!,
                                    width: context.dynamicWidth(0.37),
                                    height: context.dynamicWidth(0.37),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.255),
                      width: context.dynamicWidth(1),
                      child: Padding(
                        padding: leftPadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name & Surname',
                              style: context.textStyleGrey(context),
                            ),
                            CustomTextField(
                              textInputAction: TextInputAction.next,
                              controller: viewModel.firstnameController,
                              hintText: 'John Doe',
                              validator: (value) => ProfileUpdateValidation()
                                  .checkValidName(value, context),
                              isValid: (value) =>
                                  ProfileUpdateValidation().checkValidName(
                                    value,
                                    context,
                                  ) ==
                                  null,
                            ),
                            context.sizedHeightBoxNormal,
                            Text(
                              'Gender',
                              style: context.textStyleGrey(context),
                            ),
                            Padding(
                              padding: context.onlyTopPaddingLow,
                              child: DropdownMenu(
                                width: containerWidth,
                                textStyle: context
                                    .textStyleGrey(context)
                                    .copyWith(fontWeight: FontWeight.w600),
                                controller: viewModel.genderController,
                                hintText: 'Select Your Gender',
                                dropdownMenuEntries: const <DropdownMenuEntry<
                                    String>>[
                                  DropdownMenuEntry(
                                    value: 'Male',
                                    label: 'Male (He/Him)',
                                  ),
                                  DropdownMenuEntry(
                                    value: 'Female',
                                    label: 'Female (She/Her)',
                                  ),
                                  DropdownMenuEntry(
                                    value: 'Other',
                                    label: 'Other (They/Them)',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    context.sizedHeightBoxMedium,
                    CustomContinueButton(
                      buttonText: 'Set',
                      // Add user details when set button is pressed
                      onPressed: () {
                        // Check validaitons
                        if (viewModel.formKey.currentState!.validate()) {
                          // Only add the event if validation passes
                          context
                              .read<ProfileUpdateViewModel>()
                              .add(ProfileUpdateAddUserEvent(context: context));
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
