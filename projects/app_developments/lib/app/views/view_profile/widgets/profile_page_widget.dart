import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_event.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_state.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_view_model.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/custom_profile_card.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = BlocProvider.of<ProfileViewModel>(context)
      ..add(ProfileFetchUserDataEvent());

    return BlocBuilder<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        // Get screen height and width using MediaQuery
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Tag square container
        double containerWidth;
        double containerHeight;
        double tagSquarePosition;
        double textfieldWidth;

        //  left padding
        EdgeInsets leftPadding;

        // Height
        if (screenHeight <= 600) {
          // Small screens
          containerHeight = context.dynamicHeight(0.085);
        } else if (screenHeight <= 800) {
          // Small screens
          containerHeight = context.dynamicHeight(0.065);
        } else if (screenHeight <= 900) {
          // Medium screens
          containerHeight = context.dynamicHeight(0.07);
        } else if (screenHeight <= 1080) {
          // Medium screens
          containerHeight = context.dynamicHeight(0.08);
        } else {
          containerHeight = context.dynamicHeight(0.07);
          // Large screens
        }

        // Width
        if (screenWidth <= 600) {
          // Very small screens
          leftPadding = EdgeInsets.zero;
          tagSquarePosition = 0.34;
          containerWidth = context.dynamicWidth(0.08);
        } else if (screenWidth <= 800) {
          // Small screens
          leftPadding = context.onlyLeftPaddingLow;
          tagSquarePosition = 0.36;
          containerWidth = context.dynamicWidth(0.06);
        } else if (screenWidth <= 900) {
          // Medium screens
          leftPadding = context.onlyLeftPaddingMedium;
          tagSquarePosition = 0.39;
          containerWidth = context.dynamicWidth(0.05);
        } else if (screenWidth <= 1080) {
          // Medium Large screens
          leftPadding = context.onlyLeftPaddingHigh;
          tagSquarePosition = 0.395;
          containerWidth = context.dynamicWidth(0.04);
        } else {
          // Large screens
          leftPadding = context.onlyLeftPaddingHigh * 2;
          tagSquarePosition = 0.445;
          containerWidth = context.dynamicWidth(0.03);
        }
        if (state is ProfileLoadDataState) {
          return SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: BackButtonWithTitle(
                      title: 'Profile Settings',
                      ontap: () {
                        context.router.push(const HomeViewRoute());
                      }),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.085),
                  width: context.dynamicWidth(1),
                  child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Your Profile Information',
                        style: context.textStyleGrey(context).copyWith(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.16),
                  width: context.dynamicWidth(1),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<ProfileViewModel>(context)
                                .add(ProfileChangeImageEvent());
                          },
                          child: CircleAvatar(
                            radius: context.dynamicHeight(0.09),
                            backgroundColor:
                                AppLightColorConstants.contentTeritaryColor,
                            backgroundImage: NetworkImage(
                              state.profileImageUrl,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: context.dynamicHeight(0.1),
                        right: context.dynamicWidth(tagSquarePosition),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<ProfileViewModel>(context)
                                .add(ProfileChangeImageEvent());
                          },
                          child: Container(
                            height: containerHeight,
                            width: containerWidth,
                            decoration: const BoxDecoration(
                                color: AppLightColorConstants.primaryColor,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              Assets.images.svg.tagSquare,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: context.onlyTopPaddingMedium.top,
                  ),
                  child: Padding(
                    padding: context.onlyLeftPaddingLow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: leftPadding,
                          child: Text(
                            'Personal Information',
                            style:
                                context.textStyleTitleBarlow(context).copyWith(
                                      fontSize: 18,
                                      color: AppLightColorConstants.primaryColor
                                          .withOpacity(0.85),
                                    ),
                          ),
                        ),
                        context.sizedHeightBoxLower,
                        SizedBox(
                          height: context.dynamicHeight(0.3),
                          width: context.dynamicWidth(0.88),
                          child: Column(
                            children: [
                              CustomProfileCard(
                                title: 'UserID',
                                description: AuthenticationRepository()
                                        .getCurrentUserId() ??
                                    '',
                              ),
                              context.sizedHeightBoxLower,
                              CustomProfileCard(
                                title: 'Username',
                                description: state.firstName,
                              ),
                              context.sizedHeightBoxLower,
                              CustomProfileCard(
                                title: 'Email',
                                description: state.email,
                              ),
                              context.sizedHeightBoxLower,
                              CustomProfileCard(
                                title: 'Phone Number',
                                description: '+90 ${state.phoneNumber}',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: leftPadding,
                          child: Text(
                            'Security',
                            style:
                                context.textStyleTitleBarlow(context).copyWith(
                                      fontSize: 18,
                                      color: AppLightColorConstants.primaryColor
                                          .withOpacity(0.85),
                                    ),
                          ),
                        ),
                        context.sizedHeightBoxLower,
                        SizedBox(
                          height: context.dynamicHeight(0.1),
                          width: context.dynamicWidth(0.88),
                          child: Column(
                            children: [
                              CustomProfileCard(
                                ontap: () {
                                  viewModel.add(
                                    ProfileSelectedPageEvent(selectedPage: 2),
                                  );
                                },
                                title: 'Change Password',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
