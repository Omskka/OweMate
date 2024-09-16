// ignore_for_file: use_build_context_synchronously

import 'package:app_developments/app/views/view_messages/view_model/messages_event.dart';
import 'package:app_developments/app/views/view_messages/view_model/messages_state.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/user_messages.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../view_model/messages_view_model.dart';

class MessagesViewPageWidget extends StatelessWidget {
  const MessagesViewPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesViewModel, MessagesState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<MessagesViewModel>(context);

        final friendName = state.selectedUser?[0]['Name'] ?? 'No Name';

        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        // Define responsive variables
        double containerHeight;
        double circleAvatarWidth;
        double cardWidth;

        // Height
        if (screenHeight <= 600) {
          containerHeight = 0.21;
        } else if (screenHeight <= 800) {
          containerHeight = 0.27;
        } else if (screenHeight <= 900) {
          containerHeight = 0.25;
        } else if (screenHeight <= 1080) {
          containerHeight = 0.23;
        } else {
          containerHeight = 0.22;
        }

        // Width
        if (screenWidth <= 600) {
          circleAvatarWidth = 2.2;
          cardWidth = context.dynamicWidth(0.75);
        } else if (screenWidth <= 800) {
          circleAvatarWidth = 1.4;
          cardWidth = context.dynamicWidth(0.6);
        } else if (screenWidth <= 900) {
          circleAvatarWidth = 1.3;
          cardWidth = context.dynamicWidth(0.55);
        } else if (screenWidth <= 1080) {
          circleAvatarWidth = 1;
          cardWidth = context.dynamicWidth(0.45);
        } else {
          circleAvatarWidth = 0.8;
          cardWidth = context.dynamicWidth(0.4);
        }
        return RefreshIndicator(
          color: AppLightColorConstants.primaryColor,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            // Dispatch the initial event to refresh the data
            context.read<MessagesViewModel>().add(
                  MessagesViewActionsEvent(
                      context: context, selectedUser: state.selectedUser),
                );
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                BackButtonWithTitle(
                  title: 'View Messages',
                  ontap: () {
                    viewModel.add(
                      MessagesSelectedPageEvent(
                        context: context,
                        selectedPage: 1,
                      ),
                    );
                    viewModel.add(MessagesInitialEvent());
                  },
                ),
                context.sizedHeightBoxLow,
                Container(
                  height: context.dynamicHeight(containerHeight),
                  width: context.dynamicWidth(0.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(context.normalRadius),
                  ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center align the content
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center align horizontally
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'See all messages from',
                          style: context
                              .textStyleGrey(context)
                              .copyWith(fontSize: 17),
                        ),
                      ),
                      context.sizedHeightBoxLow,
                      // Display the profile image
                      Container(
                        width: context.dynamicWidth(
                            0.11 * circleAvatarWidth), // Adjust size as needed
                        height: context.dynamicWidth(
                            0.11 * circleAvatarWidth), // Ensure it's a square
                        decoration: BoxDecoration(
                          shape: BoxShape
                              .circle, // Make sure the border is circular
                          border: Border.all(
                            color: AppLightColorConstants.contentTeritaryColor
                                .withOpacity(0.45), // Border color
                            width: 3.0, // Border width
                          ),
                        ),
                        child: CircleAvatar(
                          radius: context
                              .dynamicWidth(0.16), // Adjust size as needed
                          backgroundImage: NetworkImage(
                            state.selectedUser?[0]['profileImageUrl'] ?? '',
                          ), // Use a default image or handle null
                          backgroundColor: Colors
                              .transparent, // Set a transparent background if needed
                        ),
                      ),

                      // Space between image and text
                      context.sizedHeightBoxLower,
                      // Display the user's name
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          friendName, // Provide a default name if null
                          style: context.textStyleTitleBarlow(context).copyWith(
                                fontSize: 18,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.05),
                  width: context.dynamicWidth(1),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Tap to view messages',
                      style: context.textStyleGrey(context).copyWith(
                            fontSize: 17,
                          ),
                    ),
                  ),
                ),
                context.sizedHeightBoxLow,
                SizedBox(
                  height: context.dynamicHeight(0.4),
                  width: cardWidth,
                  child: state is MessagesLoadingState
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: context.onlyTopPaddingHigh,
                            child: const CircularProgressIndicator(),
                          ),
                        )
                      : state.combinedFilteredList.isEmpty
                          ? SizedBox(
                              child: FutureBuilder(
                                future: Future.delayed(
                                  // 0.5 second delay
                                  const Duration(milliseconds: 500),
                                ),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Show loading spinner while waiting for 1 second
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    // After 1 second, show the main content
                                    return Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            child: SvgPicture.asset(
                                              Assets.images.svg.emptyEnvelope,
                                              height:
                                                  context.dynamicHeight(0.2),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'No messages found',
                                              style: context
                                                  .textStyleGreyBarlow(context)
                                                  .copyWith(
                                                    fontSize: 18,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                          : Scrollbar(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: state.combinedFilteredList.length,
                                itemBuilder: (context, index) {
                                  final combinedFilteredList =
                                      state.combinedFilteredList[index];

                                  final amount = combinedFilteredList['amount']
                                          ?.toString() ??
                                      '0';
                                  final date =
                                      combinedFilteredList['date'] ?? '';
                                  final status =
                                      combinedFilteredList['status'] ??
                                          'pending';
                                  final userMessage =
                                      combinedFilteredList['message'] ??
                                          'Error fetching message!';
                                  final declineMessage =
                                      combinedFilteredList['declineMessage'] ??
                                          'Error fetching message!';
                                  final paidMessage =
                                      combinedFilteredList['paidMessage'] ??
                                          'Error fetching message!';
                                  return GestureDetector(
                                    onTap: () {
                                      // set up the buttons
                                      Widget continueButton = TextButton(
                                        child: const Text("Continue"),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Dismiss the dialog
                                        },
                                      );

                                      // set up the AlertDialog
                                      AlertDialog alert = AlertDialog(
                                        title: Text(
                                          "Message",
                                          style: context
                                              .textStyleGreyBarlow(context),
                                        ),
                                        content: status == 'paid'
                                            ? RichText(
                                                text: TextSpan(
                                                  style: context
                                                      .textStyleGreyBarlow(
                                                          context), // Default style for all text
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "$friendName's Message:\n", // Bold only for this label
                                                      style: context
                                                          .textStyleGreyBarlow(
                                                              context),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "$paidMessage\n\n", // Normal weight for the message
                                                      style:
                                                          context.textStyleGrey(
                                                              context),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "Your message:\n", // Bold only for this label
                                                      style: context
                                                          .textStyleGreyBarlow(
                                                              context),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "$userMessage", // Normal weight for the message
                                                      style:
                                                          context.textStyleGrey(
                                                              context),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : RichText(
                                                text: TextSpan(
                                                  style: context
                                                      .textStyleGreyBarlow(
                                                          context), // Default style for all text
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "Your message:\n", // Bold only for this label
                                                      style: context
                                                          .textStyleGreyBarlow(
                                                              context),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "$userMessage\n\n", // Normal weight for the message
                                                      style:
                                                          context.textStyleGrey(
                                                              context),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "$friendName's Message:\n",
                                                      style: context
                                                          .textStyleGreyBarlow(
                                                              context),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "$declineMessage\n", // Normal weight for the message
                                                      style:
                                                          context.textStyleGrey(
                                                              context),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        actions: [
                                          continueButton,
                                        ],
                                      );

                                      // show the dialog
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: context.onlyBottomPaddingNormal,
                                      child: UserMessages(
                                        amount: amount,
                                        date: date,
                                        status: status,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
