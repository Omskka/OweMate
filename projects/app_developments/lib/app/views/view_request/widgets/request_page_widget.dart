// ignore_for_file: use_build_context_synchronously

import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_request/view_model/request_event.dart';
import 'package:app_developments/app/views/view_request/view_model/request_state.dart';
import 'package:app_developments/app/views/view_request/view_model/request_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RequestPageWidget extends StatelessWidget {
  const RequestPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestViewModel, RequestState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<RequestViewModel>(context);
        // Handle the case where maxWidth or maxHeight is Infinity
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // Define responsive variables
        double containerWidth;
        EdgeInsets leftPadding;
        double circleAvatarWidth;

        // Height
        if (screenHeight <= 600) {
        } else if (screenHeight <= 800) {
        } else if (screenHeight <= 900) {
        } else if (screenHeight <= 1080) {
        } else {}

        // Width
        if (screenWidth <= 600) {
          containerWidth = 0.8;
          leftPadding = context.onlyLeftPaddingMedium;
          circleAvatarWidth = 1.55;
        } else if (screenWidth <= 800) {
          containerWidth = 0.68;
          leftPadding = context.onlyLeftPaddingMedium;
          circleAvatarWidth = 1.5;
        } else if (screenWidth <= 900) {
          containerWidth = 0.63;
          leftPadding = context.onlyLeftPaddingHigh * 1.5;
          circleAvatarWidth = 1.4;
        } else if (screenWidth <= 1080) {
          containerWidth = 0.6;
          leftPadding = context.onlyLeftPaddingHigh * 1.7;
          circleAvatarWidth = 1.1;
        } else {
          containerWidth = 0.5;
          leftPadding = context.onlyLeftPaddingHigh * 4;

          circleAvatarWidth = 0.9;
        }

        return RefreshIndicator(
          color: AppLightColorConstants.primaryColor,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            // Dispatch the initial event to refresh the data
            context.read<RequestViewModel>().add(RequestInitialEvent());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                BackButtonWithTitle(
                  title: 'Request Money',
                  ontap: () {
                    context.router.push(
                      const DebtsViewRoute(),
                    );
                  },
                ),
                SizedBox(
                  width: context.dynamicWidth(0.85),
                  height: context.dynamicHeight(0.1),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Center(
                      child: Text(
                        'Choose from your friends list to quickly request money,\nmaking it easy to manage and track shared expenses.',
                        textAlign: TextAlign.center,
                        style: context.textStyleGrey(context).copyWith(
                              fontSize: 15,
                            ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.dynamicWidth(1),
                  height: context.dynamicHeight(0.06),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: leftPadding,
                        child: SvgPicture.asset(
                          Assets.images.svg.friendsIcon,
                          colorFilter: ColorFilter.mode(
                            ColorThemeUtil.getBgInverseColor(context),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      context.sizedWidthBoxLow,
                      Text(
                        'Friends',
                        style: context
                            .textStyleGreyBarlow(context)
                            .copyWith(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.65),
                  width: context.dynamicWidth(containerWidth),
                  child: state is RequestLoadingState
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: context.onlyTopPaddingHigh,
                            child: CircularProgressIndicator(
                              color: ColorThemeUtil.getContentTeritaryColor(
                                  context),
                            ),
                          ),
                        )
                      : state.friends.isEmpty
                          ? SizedBox(
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context.router.push(
                                              const AddFriendsViewRoute());
                                        },
                                        child: SvgPicture.asset(
                                          Assets.images.svg.noFriends,
                                          height: context.dynamicHeight(0.3),
                                        ),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Your friend list is empty',
                                          style: context
                                              .textStyleGreyBarlow(context)
                                              .copyWith(
                                                fontSize: 18,
                                              ),
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          : Scrollbar(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: state.friends.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        // remove splash effect
                                        splashFactory: NoSplash.splashFactory,
                                        onTap: () {},
                                        child: Padding(
                                          padding: context.onlyTopPaddingNormal,
                                          child: SizedBox(
                                            height: context.dynamicHeight(0.1),
                                            width: context.dynamicWidth(0.8),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: context.dynamicWidth(0.11 *
                                                      circleAvatarWidth), // Adjust size as needed
                                                  height: context.dynamicWidth(
                                                      0.11 *
                                                          circleAvatarWidth), // Ensure it's a square
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape
                                                        .circle, // Make sure the border is circular
                                                    border: Border.all(
                                                      color: AppLightColorConstants
                                                          .contentTeritaryColor
                                                          .withOpacity(
                                                              0.45), // Border color
                                                      width:
                                                          3.0, // Border width
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: context
                                                        .dynamicWidth(0.07),
                                                    backgroundColor:
                                                        AppLightColorConstants
                                                            .contentTeritaryColor,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      state.friends[index][
                                                              'profileImageUrl'] ??
                                                          '', // Use index to get the correct user
                                                    ),
                                                  ),
                                                ),
                                                context.sizedWidthBoxNormal,
                                                Expanded(
                                                  child: Text(
                                                    state.friends[index]
                                                            ['Name'] ??
                                                        'Unknown User',
                                                    style: context
                                                        .textStyleGrey(context)
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: ColorThemeUtil
                                                              .getBgInverseColor(
                                                                  context),
                                                        ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    viewModel.add(
                                                      RequestNavigateToNextPageEvent(
                                                        selectedPage: 2,
                                                        context: context,
                                                        selectedUser: [
                                                          state.friends[index]
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(Icons.send),
                                                      context.sizedWidthBoxLow,
                                                      const Text('Send')
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Add divider if not the last item
                                      if (index < state.friends.length - 1)
                                        Divider(
                                          color: AppLightColorConstants
                                              .dividerColor,
                                          thickness:
                                              1.0, // Adjust thickness as needed
                                          indent: context.dynamicWidth(
                                              0.1), // Indent from left
                                          endIndent: context.dynamicWidth(
                                              0.1), // Indent from right
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
