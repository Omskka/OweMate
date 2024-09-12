import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_notifications/view_model/notifications_event.dart';
import 'package:app_developments/app/views/view_notifications/view_model/notifications_state.dart';
import 'package:app_developments/app/views/view_notifications/view_model/notifications_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/friend_request_card.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NotificationsPageWidget extends StatelessWidget {
  const NotificationsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsViewModel, NotificationsState>(
      builder: (context, state) {
        // Get viewmodel
        final viewModel = BlocProvider.of<NotificationsViewModel>(context);

        // Get screen height and width using MediaQuery
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Define responsive variables
        EdgeInsets leftPadding;
        double containerWidth;

        // Height
        if (screenHeight <= 680) {
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
          // very Small screens
          leftPadding = context.onlyLeftPaddingMedium;
          containerWidth = 1;
        } else if (screenWidth <= 800) {
          // Small screens
          leftPadding = context.onlyLeftPaddingMedium;
          containerWidth = 1;
        } else if (screenWidth <= 900) {
          // Medium screens
          leftPadding = context.onlyLeftPaddingMedium;
          containerWidth = 0.8;
        } else if (screenWidth <= 1080) {
          // Medium Large screens
          leftPadding = context.onlyLeftPaddingHigh;
          containerWidth = 0.7;
        } else {
          // Large screens
          leftPadding = context.onlyLeftPaddingHigh;
          containerWidth = 0.6;
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              BackButtonWithTitle(
                title: 'Notifications',
                ontap: () {
                  context.router.push(
                    const HomeViewRoute(),
                  );
                },
              ),
              context.sizedHeightBoxLower,
              SizedBox(
                height: context.dynamicHeight(0.05),
                width: context.dynamicWidth(1),
                child: Padding(
                  padding: leftPadding,
                  child: Align(
                    alignment: Alignment
                        .centerLeft, // or Alignment.centerRight for right alignment
                    child: Text(
                      'Friend requests',
                      style: context.textStyleTitleBarlow(context),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.03),
                width: context.dynamicWidth(0.9),
                child: const Divider(
                  color: AppLightColorConstants.infoColor,
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.45),
                width: context.dynamicWidth(containerWidth),
                child: state.friendRequests.isEmpty
                    ? SizedBox(
                        child: Center(
                            child: Column(
                          children: [
                            context.sizedHeightBoxLow,
                            SvgPicture.asset(
                              Assets.images.svg.mailbox,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'You currently have no notifications',
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
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.friendRequests.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            // remove splash effect
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {},
                            child: Padding(
                              padding: context.onlyTopPaddingNormal,
                              child: FriendRequestCard(
                                onPressedAccept: () {
                                  context.read<NotificationsViewModel>().add(
                                        NotificationsAcceptEvent(
                                            friendId:
                                                state.friendRequests[index]
                                                    ['userId'],
                                            context: context),
                                      );
                                },
                                onPressedDecline: () {
                                  context.read<NotificationsViewModel>().add(
                                        NotificationsDeclineEvent(
                                            friendId:
                                                state.friendRequests[index]
                                                    ['userId'],
                                            context: context),
                                      );
                                },
                                profileImageUrl: state.friendRequests[index]
                                    ['profileImageUrl'],
                                userName: state.friendRequests[index]['Name'] ??
                                    'Unknown User',
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
