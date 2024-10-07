// ignore_for_file: use_build_context_synchronously

import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_home/view_model/home_event.dart';
import 'package:app_developments/app/views/view_home/view_model/home_state.dart';
import 'package:app_developments/app/views/view_home/view_model/home_view_model.dart';
import 'package:app_developments/core/auth/firebase_api.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/money_debt_card.dart';
import 'package:app_developments/core/widgets/money_request_card.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Declare the lists outside the conditional blocks
    List filteredRequestedMoney = [];
    List filteredOwedMoney = [];
    final viewModel = BlocProvider.of<HomeViewModel>(context);
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        FirebaseApi().initNotifications();
        // Fetch friends' data if not already fetched
        if (state is HomeDataLoadedState) {
          final requestedMoney =
              state.userData['requestedMoney'] as List? ?? [];
          final owedMoney = state.userData['owedMoney'] as List? ?? [];

          // Dispatch events to fetch each friend's data
          for (var request in requestedMoney) {
            String friendUserId = request['friendUserId'] ?? '';
            // Fetch friend's data if not already fetched
            if (!state.friendsUserData.containsKey(friendUserId)) {
              context.read<HomeViewModel>().add(
                    HomefetchRequestDataEvent(friendsUserId: friendUserId),
                  );
            }
          }

          for (var debt in owedMoney) {
            String friendUserId = debt['friendUserId'] ?? '';
            // Fetch friend's data if not already fetched
            if (!state.friendsUserData.containsKey(friendUserId)) {
              context.read<HomeViewModel>().add(
                    HomefetchRequestDataEvent(friendsUserId: friendUserId),
                  );
            }
          }
        }

        // Filter requestedMoney and owedMoney by status
        if (state is HomeDataLoadedState) {
          if (state.isOrderReversed == false) {
            filteredRequestedMoney = (state.userData['requestedMoney'] as List?)
                    ?.where((item) => item['status'] == 'pending')
                    .toList()
                    .reversed
                    .toList() ??
                [];

            filteredOwedMoney = (state.userData['owedMoney'] as List?)
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
        EdgeInsets leftPadding;
        EdgeInsets cardLeftPadding;

        // Width
        if (screenWidth <= 600) {
          leftPadding = EdgeInsets.zero;
          cardLeftPadding = context.onlyLeftPaddingMedium;
        } else if (screenWidth <= 800) {
          leftPadding = EdgeInsets.zero;
          cardLeftPadding = context.onlyLeftPaddingMedium;
        } else if (screenWidth <= 900) {
          leftPadding = context.onlyLeftPaddingNormal;
          cardLeftPadding = context.onlyLeftPaddingMedium;
        } else if (screenWidth <= 1080) {
          leftPadding = context.onlyLeftPaddingNormal;
          cardLeftPadding = context.onlyLeftPaddingMedium;
        } else {
          leftPadding = context.onlyLeftPaddingHigh;
          cardLeftPadding = context.onlyLeftPaddingHigh;
        }

        return PopScope(
          canPop: false,
          child: RefreshIndicator(
            color: AppLightColorConstants.primaryColor,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              // Dispatch the initial event to refresh the data
              context
                  .read<HomeViewModel>()
                  .add(HomeInitialEvent(context: context));
            },
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.sizedHeightBoxLow,
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
                          'Home',
                          style: context.textStyleGrey(context).copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color:
                                    ColorThemeUtil.getBgInverseColor(context),
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
                  SizedBox(
                    height: context.dynamicHeight(0.08),
                    width: context.dynamicWidth(1),
                    child: Center(
                      child: Text(
                        'Manage your debts and requests easily.\nTap on the cards to view messages.',
                        textAlign: TextAlign.center,
                        style: context
                            .textStyleGrey(context)
                            .copyWith(fontSize: 17),
                      ),
                    ),
                  ),
                  // Money You Owe Section
                  SizedBox(
                    height: context.dynamicHeight(0.05),
                    width: context.dynamicWidth(1),
                    child: Padding(
                      padding: context.onlyLeftPaddingMedium,
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Padding(
                                  padding: leftPadding,
                                  child: Text(
                                    key: viewModel.debtsKey,
                                    'Pending Debts',
                                    style: context
                                        .textStyleGreyBarlow(context)
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: context.onlyRightPaddingNormal,
                            child: GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      'See All',
                                      style: context
                                          .textStyleGrey(context)
                                          .copyWith(
                                            color: ColorThemeUtil
                                                .getContentTeritaryColor(
                                                    context),
                                          ),
                                    ),
                                    context.sizedWidthBoxLow,
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.25),
                    width: context.dynamicWidth(1),
                    child: state is HomeLoadingState
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
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
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
                                          content: Text(
                                            "${debt['message']}",
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
                                      child: MoneyDebtCard(
                                        profileImageUrl: profileImageUrl,
                                        amount: amount,
                                        name: friendName,
                                        date: date,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                  // Money Owed to You Section
                  SizedBox(
                    height: context.dynamicHeight(0.05),
                    width: context.dynamicWidth(1),
                    child: Padding(
                      padding: context.onlyLeftPaddingMedium,
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Padding(
                                  padding: leftPadding,
                                  child: Text(
                                    key: viewModel.requestsKey,
                                    'Pending Requests',
                                    style: context
                                        .textStyleGreyBarlow(context)
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: context.onlyRightPaddingNormal,
                            child: GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      'See All',
                                      style: context
                                          .textStyleGrey(context)
                                          .copyWith(
                                            color: ColorThemeUtil
                                                .getContentTeritaryColor(
                                                    context),
                                          ),
                                    ),
                                    context.sizedWidthBoxLow,
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.25),
                    width: context.dynamicWidth(1),
                    child: state is HomeLoadingState
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
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
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
                                            context.read<HomeViewModel>().add(
                                                  HomefetchDeleteRequestEvent(
                                                    requestId:
                                                        request['requestId'],
                                                    friendUserId: friendUserId,
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
                                      child: MoneyRequestCard(
                                        profileImageUrl: profileImageUrl,
                                        amount: amount,
                                        name: friendName,
                                        date: date,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.images.svg.settled,
                                    width: 100,
                                  ),
                                  Text(
                                    'Nobody owes you any money.\nYou\'re all set!',
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
