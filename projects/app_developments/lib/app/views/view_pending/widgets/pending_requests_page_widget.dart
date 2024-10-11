// ignore_for_file: use_build_context_synchronously

import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_pending/view_model/pending_event.dart';
import 'package:app_developments/app/views/view_pending/view_model/pending_state.dart';
import 'package:app_developments/app/views/view_pending/view_model/pending_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/core/widgets/money_debt_card.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PendingRequestsPageWidget extends StatelessWidget {
  const PendingRequestsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Declare the lists outside the conditional blocks
    List filteredRequestedMoney = [];
    final viewModel = BlocProvider.of<PendingViewModel>(context);

    return BlocBuilder<PendingViewModel, PendingState>(
      builder: (context, state) {
        // Fetch friends' data if not already fetched
        if (state is PendingDataLoadedState) {
          final requestedMoney =
              state.userData['requestedMoney'] as List? ?? [];
          final owedMoney = state.userData['owedMoney'] as List? ?? [];

          // Dispatch events to fetch each friend's data
          for (var request in requestedMoney) {
            String friendUserId = request['friendUserId'] ?? '';
            // Fetch friend's data if not already fetched
            if (!state.friendsUserData.containsKey(friendUserId)) {
              context.read<PendingViewModel>().add(
                    PendingfetchRequestDataEvent(friendsUserId: friendUserId),
                  );
            }
          }
        }

        // Filter requestedMoney and owedMoney by status
        if (state is PendingDataLoadedState) {
          if (state.isOrderReversed == false) {
            filteredRequestedMoney = (state.userData['requestedMoney'] as List?)
                    ?.where((item) => item['status'] == 'pending')
                    .toList()
                    .reversed
                    .toList() ??
                [];
          } else {
            filteredRequestedMoney = (state.userData['requestedMoney'] as List?)
                    ?.where((item) => item['status'] == 'pending')
                    .toList() ??
                [];
          }
        }

        // Get screen height and width using MediaQuery
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Determine height and width based on screen dimensions
        EdgeInsets cardLeftPadding;

        // Width
        if (screenWidth <= 600) {
          cardLeftPadding = context.onlyLeftPaddingNormal;
        } else if (screenWidth <= 800) {
          cardLeftPadding = context.onlyLeftPaddingNormal;
        } else if (screenWidth <= 900) {
          cardLeftPadding = context.onlyLeftPaddingNormal;
        } else if (screenWidth <= 1080) {
          cardLeftPadding = context.onlyLeftPaddingNormal;
        } else {
          cardLeftPadding = context.onlyLeftPaddingMedium;
        }
        return PopScope(
          canPop: false,
          child: RefreshIndicator(
            color: AppLightColorConstants.primaryColor,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              // Dispatch the initial event to refresh the data
              context.read<PendingViewModel>().add(PendingInitialEvent(
                    context: context,
                    selectedPage: state.selectedPage!,
                  ));
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButtonWithTitle(
                    title: 'Pending Requests',
                    ontap: () {
                      context.router.push(const HomeViewRoute());
                    },
                  ),
                  context.sizedHeightBoxLow,
                  SizedBox(
                    height: context.dynamicHeight(0.8),
                    width: context.dynamicWidth(1),
                    child: state is PendingLoadingState
                        ? Center(
                            child: CircularProgressIndicator(
                              color: ColorThemeUtil.getContentTeritaryColor(
                                  context),
                            ),
                          )
                        : filteredRequestedMoney.isNotEmpty
                            ? Padding(
                                padding:
                                    EdgeInsets.only(left: cardLeftPadding.left),
                                child: Scrollbar(
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 2 items per row
                                      crossAxisSpacing:
                                          5.0, // spacing between items horizontally
                                      mainAxisSpacing: context.dynamicHeight(
                                        0.02,
                                      ), // spacing between items vertically
                                    ),
                                    itemCount: filteredRequestedMoney.length,
                                    itemBuilder: (context, index) {
                                      final request =
                                          filteredRequestedMoney[index];
                                      final amount =
                                          request['amount']?.toString() ?? '0';
                                      final date = request['date'] ?? '';
                                      final friendUserId =
                                          request['friendUserId'] ?? '';

                                      // Fetch friend's data from state
                                      final friendData =
                                          state.friendsUserData[friendUserId] ??
                                              {};
                                      final friendName =
                                          friendData['firstName'] ?? 'Unknown';
                                      final profileImageUrl =
                                          friendData['profileImageUrl'] ?? '';

                                      return GestureDetector(
                                        onTap: () {
                                          // set up the buttons
                                          Widget continueButton = TextButton(
                                            child: Text(
                                              "Continue",
                                              style: TextStyle(
                                                color: ColorThemeUtil
                                                    .getContentTeritaryColor(
                                                  context,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Dismiss the dialog
                                            },
                                          );
                                          Widget deleteButton = TextButton(
                                            child: const Text(
                                              "Delete Request",
                                              style: TextStyle(
                                                color: AppLightColorConstants
                                                    .errorColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              // Action for the Delete button
                                              context
                                                  .read<PendingViewModel>()
                                                  .add(
                                                    PendingfetchDeleteRequestEvent(
                                                      requestId:
                                                          request['requestId'],
                                                      friendUserId:
                                                          friendUserId,
                                                      context: context,
                                                    ),
                                                  );
                                              Navigator.of(context)
                                                  .pop(); // Dismiss the dialog
                                            },
                                          );
                                          // set up the AlertDialog
                                          AlertDialog alert = AlertDialog(
                                            title: Text(
                                              "Your Request Message",
                                              style: context
                                                  .textStyleGreyBarlow(context),
                                            ),
                                            content: Text(
                                              "${request['message']}",
                                            ),
                                            actions: [
                                              deleteButton,
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
                                        child: MoneyDebtCard(
                                          profileImageUrl: profileImageUrl,
                                          amount: amount,
                                          name: friendName,
                                          date: date,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  context.sizedHeightBoxHigh,
                                  context.sizedHeightBoxHigh,
                                  SvgPicture.asset(
                                    Assets.images.svg.settled,
                                    width: 100,
                                  ),
                                  Text(
                                    'You don\'t owe anyone any money.\nYou\'re all clear!',
                                    style: context.textStyleGrey(context),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
