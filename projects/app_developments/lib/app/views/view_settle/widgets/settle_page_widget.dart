import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_event.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_state.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_view_model.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/incoming_requests_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettlePageWidget extends StatelessWidget {
  const SettlePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettleViewModel, SettleState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<SettleViewModel>(context);

        // Fetch friends' data if not already fetched
        if (state is SettleDataLoadedState) {
          final requestedMoney =
              state.userData['requestedMoney'] as List? ?? [];
          final owedMoney = state.userData['owedMoney'] as List? ?? [];

          // Dispatch events to fetch each friend's data
          for (var request in requestedMoney) {
            String friendUserId = request['friendUserId'] ?? '';
            // Fetch friend's data if not already fetched
            if (!state.friendsUserData.containsKey(friendUserId)) {
              context.read<SettleViewModel>().add(
                    SettlefetchRequestDataEvent(friendsUserId: friendUserId),
                  );
            }
          }

          for (var debt in owedMoney) {
            String friendUserId = debt['friendUserId'] ?? '';
            // Fetch friend's data if not already fetched
            if (!state.friendsUserData.containsKey(friendUserId)) {
              context.read<SettleViewModel>().add(
                    SettlefetchRequestDataEvent(friendsUserId: friendUserId),
                  );
            }
          }
        }
        // Handle the case where maxWidth or maxHeight is Infinity
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // Define responsive variables
        EdgeInsets leftPadding;
        double circleAvatarWidth;

        // Height
        if (screenHeight <= 600) {
        } else if (screenHeight <= 800) {
        } else if (screenHeight <= 900) {
        } else if (screenHeight <= 1080) {
        } else {}

        // Height
        if (screenHeight <= 600) {
        } else if (screenHeight <= 800) {
        } else if (screenHeight <= 900) {
        } else if (screenHeight <= 1080) {
        } else {}

        // Width
        if (screenWidth <= 600) {
          leftPadding = context.onlyLeftPaddingMedium;

          circleAvatarWidth = 2.2;
        } else if (screenWidth <= 800) {
          leftPadding = context.onlyLeftPaddingMedium * 2;

          circleAvatarWidth = 1.4;
        } else if (screenWidth <= 900) {
          leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.37)) / 2);

          circleAvatarWidth = 1.3;
        } else if (screenWidth <= 1080) {
          leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.37)) / 2);

          circleAvatarWidth = 1;
        } else {
          leftPadding = EdgeInsets.symmetric(
              horizontal: (screenWidth - context.dynamicWidth(0.37)) / 2);

          circleAvatarWidth = 0.8;
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButtonWithTitle(
                title: 'Settle Debts',
                ontap: () {
                  context.router.push(const DebtsViewRoute());
                },
              ),
              SizedBox(
                height: context.dynamicHeight(0.1),
                width: context.dynamicWidth(1),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Mark requests as paid or decline with a message, giving\nyou control over how you settle up.',
                    style:
                        context.textStyleGrey(context).copyWith(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              context.sizedHeightBoxLower,
              SizedBox(
                height: context.dynamicHeight(0.05),
                width: context.dynamicWidth(1),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: leftPadding,
                    child: Text(
                      'Incoming Requests',
                      style: context
                          .textStyleGreyBarlow(context)
                          .copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
              context.sizedHeightBoxLow,
              Padding(
                padding: leftPadding,
                child: SizedBox(
                  height: context.dynamicHeight(0.5),
                  width: context.dynamicWidth(0.8),
                  child: state is SettleLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state.userData.containsKey('owedMoney') &&
                              state.userData['owedMoney'] != null &&
                              state.userData['owedMoney'] is List &&
                              state.userData['owedMoney'].isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: state.userData['owedMoney'].length,
                              itemBuilder: (context, index) {
                                final debt = state.userData['owedMoney'][index];

                                final amount =
                                    debt['amount']?.toString() ?? '0';
                                final date = debt['date'] ?? '';
                                final friendUserId = debt['friendUserId'] ?? '';

                                // Fetch friend's data from state
                                final friendData =
                                    state.friendsUserData[friendUserId] ?? {};
                                final friendName =
                                    friendData['firstName'] ?? 'Unknown';
                                final profileImageUrl =
                                    friendData['profileImageUrl'] ?? '';

                                return Padding(
                                  padding: context.onlyBottomPaddingNormal,
                                  child: GestureDetector(
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
                                          "$friendName's Request Message",
                                          style: context
                                              .textStyleGreyBarlow(context),
                                        ),
                                        content: Text(
                                          "${state.userData['owedMoney'][index]['message']}",
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
                                    child: IncomingRequestsCard(
                                      profileImageUrl: profileImageUrl,
                                      amount: amount,
                                      name: friendName,
                                      date: date,
                                      onMarkAsPaid: () {
                                        viewModel.add(
                                          SettleNavigateToNextPageEvent(
                                            selectedPage: 3,
                                            context: context,
                                          ),
                                        );
                                      },
                                      onDeclineRequest: () {
                                        viewModel.add(
                                          SettleNavigateToNextPageEvent(
                                            selectedPage: 2,
                                            context: context,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'You don\'t owe anyone any money.\nYou\'re all clear!',
                                  style: context.textStyleGrey(context),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
