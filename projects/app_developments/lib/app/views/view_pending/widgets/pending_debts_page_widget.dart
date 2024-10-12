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

class PendingDebtsPageWidget extends StatelessWidget {
  const PendingDebtsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Declare the lists outside the conditional blocks
    List filteredOwedMoney = [];
    final viewModel = BlocProvider.of<PendingViewModel>(context);
    return BlocBuilder<PendingViewModel, PendingState>(
      builder: (context, state) {
        // Fetch friends' data if not already fetched
        if (state is PendingDataLoadedState) {
          final owedMoney = state.userData['owedMoney'] as List? ?? [];

          for (var debt in owedMoney) {
            String friendUserId = debt['friendUserId'] ?? '';
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
            filteredOwedMoney = (state.userData['owedMoney'] as List?)
                    ?.where((item) => item['status'] == 'pending')
                    .toList()
                    .reversed
                    .toList() ??
                [];
          } else {
            filteredOwedMoney = (state.userData['owedMoney'] as List?)
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
          canPop: true,
          child: RefreshIndicator(
            color: AppLightColorConstants.primaryColor,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              // Dispatch the initial event to refresh the data
              context.read<PendingViewModel>().add(PendingInitialEvent(
                    context: context,
                    selectedPage: 1,
                  ));
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButtonWithTitle(
                    title: 'Pending Debts',
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
                        : filteredOwedMoney.isNotEmpty
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
                                    itemCount: filteredOwedMoney.length,
                                    itemBuilder: (context, index) {
                                      final debt = filteredOwedMoney[index];
                                      final amount =
                                          debt['amount']?.toString() ?? '0';
                                      final date = debt['date'] ?? '';
                                      final friendUserId =
                                          debt['friendUserId'] ?? '';

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

                                          // set up the AlertDialog
                                          AlertDialog alert = AlertDialog(
                                            title: Text(
                                              "$friendName's Request Message",
                                              style: context
                                                  .textStyleGreyBarlow(context),
                                            ),
                                            content: Text("${debt['message']}"),
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
