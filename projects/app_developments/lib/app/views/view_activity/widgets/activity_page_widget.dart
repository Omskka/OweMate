// ignore_for_file: use_build_context_synchronously

import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_event.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_state.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/recent_activity_card.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ActivityPageWidget extends StatelessWidget {
  const ActivityPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityViewModel, ActivityState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<ActivityViewModel>(context);

        // Fetch friends' data if not already fetched
        if (state is ActivityDataLoadedState) {
          final filteredRequestedMoney =
              state.filteredRequestedMoney as List? ?? [];
          final filteredOwedMoney = state.filteredOwedMoney as List? ?? [];
          final combinedFilteredList =
              state.combinedFilteredList as List? ?? [];

          // Dispatch events to fetch each friend's data
          for (var request in filteredRequestedMoney) {
            String friendUserId = request['friendUserId'] ?? '';
            // Fetch friend's data if not already fetched
            if (!state.friendsUserData.containsKey(friendUserId)) {
              context.read<ActivityViewModel>().add(
                    ActivityFetchUserDataEvent(friendUserId: friendUserId),
                  );
            }
          }

          for (var debt in filteredOwedMoney) {
            String friendUserId = debt['friendUserId'] ?? '';
            // Fetch friend's data if not already fetched
            if (!state.friendsUserData.containsKey(friendUserId)) {
              context.read<ActivityViewModel>().add(
                    ActivityFetchUserDataEvent(friendUserId: friendUserId),
                  );
            }
          }

          for (var all in combinedFilteredList) {
            String friendUserId = all['friendUserId'] ?? '';
            // Fetch friend's data if not already fetched
            if (!state.friendsUserData.containsKey(friendUserId)) {
              context.read<ActivityViewModel>().add(
                    ActivityFetchUserDataEvent(friendUserId: friendUserId),
                  );
            }
          }
        }
        // Add listener
        viewModel.requestCurrencyController.addListener(
          () {
            context
                .read<ActivityViewModel>()
                .add(ActivityRequestCurrencyEvent());
          },
        );
        // Add listener
        viewModel.debtCurrencyController.addListener(
          () {
            context.read<ActivityViewModel>().add(ActivityDebtCurrencyEvent());
          },
        );
        // Define a list of currencies
        const List<Map<String, String>> currencies = [
          {'value': 'USD (\$)', 'label': 'USD (\$)'},
          {'value': 'EURO (€)', 'label': 'EURO (€)'},
          {'value': 'TL (₺)', 'label': 'TL (₺)'},
          {'value': 'GBP (£)', 'label': 'GBP (£)'},
          {'value': 'JPY (¥)', 'label': 'JPY (¥)'},
          {'value': 'INR (₹)', 'label': 'INR (₹)'},
          {'value': 'CHF (₣)', 'label': 'CHF (₣)'},
        ];

        // Define a list of activities
        const List<Map<String, String>> activities = [
          //{'value': 'All', 'label': 'All'},
          {'value': 'Requests', 'label': 'Requests'},
          {'value': 'Debts', 'label': 'Debts'},
        ];

        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Initialise variables
        double containerWidth;
        double cardWidth;

        // Height
        if (screenHeight <= 600) {
        } else if (screenHeight <= 800) {
        } else if (screenHeight <= 900) {
        } else if (screenHeight <= 1080) {
        } else {}

        // Width
        if (screenWidth <= 600) {
          containerWidth = context.dynamicWidth(0.35);
          cardWidth = context.dynamicWidth(0.43);
          // very Small screens
        } else if (screenWidth <= 800) {
          // Small screens
          containerWidth = context.dynamicWidth(0.3);
          cardWidth = context.dynamicWidth(0.4);
        } else if (screenWidth <= 900) {
          // Medium screens
          containerWidth = context.dynamicWidth(0.25);
          cardWidth = context.dynamicWidth(0.37);
        } else if (screenWidth <= 1080) {
          // Medium Large screens
          containerWidth = context.dynamicWidth(0.2);
          cardWidth = context.dynamicWidth(0.3);
        } else {
          // Large screens
          containerWidth = context.dynamicWidth(0.15);
          cardWidth = context.dynamicWidth(0.25);
        }
        return RefreshIndicator(
          color: ColorThemeUtil.getPrimaryColor(context),
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            // Dispatch the initial event to refresh the data
            context
                .read<ActivityViewModel>()
                .add(ActivityInitialEvent(activityType: 'Requests'));
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
                        'Activity',
                        style: context.textStyleGrey(context).copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorThemeUtil.getBgInverseColor(context),
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
                context.sizedHeightBoxLow,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Total Requets
                    Container(
                      height: context.dynamicHeight(0.2),
                      width: cardWidth,
                      decoration: BoxDecoration(
                        color: ColorThemeUtil.getPrimaryColor(context),
                        borderRadius: BorderRadius.all(context.normalRadius),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Shadow color
                            spreadRadius: 3, // Spread radius
                            blurRadius: 2, // Blur radius
                            offset: const Offset(
                              0,
                              0.5,
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: context.onlyTopPaddingNormal,
                              child: Text(
                                'Total Requests',
                                style: context
                                    .textStyleGreyBarlow(context)
                                    .copyWith(
                                      fontSize: 17,
                                      color: AppLightColorConstants.bgLight,
                                    ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () async {
                              final selectedCurrency =
                                  await showModalBottomSheet<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: currencies.map((currency) {
                                      return ListTile(
                                        title: Text(currency['label']!),
                                        onTap: () {
                                          Navigator.pop(
                                              context, currency['value']);
                                        },
                                      );
                                    }).toList(),
                                  );
                                },
                              );

                              if (selectedCurrency != null) {
                                viewModel.requestCurrencyController.text =
                                    selectedCurrency;
                                context
                                    .read<ActivityViewModel>()
                                    .add(ActivityRequestCurrencyEvent());
                              }
                            },
                            child: Container(
                              padding: context.paddingNormal,
                              width: containerWidth,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: viewModel
                                      .requestCurrencyController.text.isEmpty
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Currrency',
                                          style: context
                                              .textStyleGrey(context)
                                              .copyWith(
                                                color: AppLightColorConstants
                                                    .bgLight,
                                              ),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: AppLightColorConstants.bgLight,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          viewModel
                                              .requestCurrencyController.text,
                                          style: context
                                              .textStyleGrey(context)
                                              .copyWith(
                                                color: AppLightColorConstants
                                                    .bgLight,
                                              ),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: AppLightColorConstants.bgLight,
                                        ),
                                      ],
                                    ),
                            ),
                          ),

                          Padding(
                            padding: context.onlyBottomPaddingLow,
                            child: state.requestCurrencyIndex != null
                                ? FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${viewModel.requestCurrencyController.text.trim()[viewModel.requestCurrencyController.text.length - 2]}${state.requestedMoneyTotals[state.requestCurrencyIndex!]}',
                                      style: context
                                          .textStyleGreyBarlow(context)
                                          .copyWith(
                                            fontSize: 19,
                                            color:
                                                AppLightColorConstants.bgLight,
                                          ),
                                    ),
                                  )
                                : const SizedBox(),
                          ), // Return an empty SizedBox if currencyIndex is null
                        ],
                      ),
                    ),
                    // Total owed money
                    Container(
                      height: context.dynamicHeight(0.2),
                      width: cardWidth,
                      decoration: BoxDecoration(
                        color: ColorThemeUtil.getPrimaryColor(context),
                        borderRadius: BorderRadius.all(context.normalRadius),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Shadow color
                            spreadRadius: 3, // Spread radius
                            blurRadius: 2, // Blur radius
                            offset: const Offset(
                              0,
                              0.5,
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: context.onlyTopPaddingNormal,
                              child: Text(
                                'Total Debt',
                                style: context
                                    .textStyleGreyBarlow(context)
                                    .copyWith(
                                      fontSize: 17,
                                      color: AppLightColorConstants.bgLight,
                                    ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () async {
                              final selectedCurrency =
                                  await showModalBottomSheet<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: currencies.map((currency) {
                                      return ListTile(
                                        title: Text(currency['label']!),
                                        onTap: () {
                                          Navigator.pop(
                                              context, currency['value']);
                                        },
                                      );
                                    }).toList(),
                                  );
                                },
                              );

                              if (selectedCurrency != null) {
                                viewModel.debtCurrencyController.text =
                                    selectedCurrency;
                                context
                                    .read<ActivityViewModel>()
                                    .add(ActivityDebtCurrencyEvent());
                              }
                            },
                            child: Container(
                              padding: context.paddingNormal,
                              width: containerWidth,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: viewModel
                                      .debtCurrencyController.text.isEmpty
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Currrency',
                                          style: context
                                              .textStyleGrey(context)
                                              .copyWith(
                                                color: AppLightColorConstants
                                                    .bgLight,
                                              ),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: AppLightColorConstants.bgLight,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          viewModel.debtCurrencyController.text,
                                          style: context
                                              .textStyleGrey(context)
                                              .copyWith(
                                                color: AppLightColorConstants
                                                    .bgLight,
                                              ),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: AppLightColorConstants.bgLight,
                                        ),
                                      ],
                                    ),
                            ),
                          ),

                          Padding(
                            padding: context.onlyBottomPaddingLow,
                            child: state.debtCurrencyIndex != null
                                ? FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${viewModel.debtCurrencyController.text.trim()[viewModel.debtCurrencyController.text.length - 2]}${state.owedMoneyTotals[state.debtCurrencyIndex!]}',
                                      style: context
                                          .textStyleGreyBarlow(context)
                                          .copyWith(
                                            fontSize: 19,
                                            color:
                                                AppLightColorConstants.bgLight,
                                          ),
                                    ),
                                  )
                                : const SizedBox(),
                          ), // Return an empty SizedBox if currencyIndex is null
                        ],
                      ),
                    )
                  ],
                ),
                context.sizedHeightBoxNormal,
                Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Recent Activities',
                      style: context.textStyleH2(context).copyWith(
                            fontSize: 20,
                            color:
                                ColorThemeUtil.getContentTeritaryColor(context),
                          ),
                    ),
                  ),
                ),
                context.sizedHeightBoxLower,
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final activityType = await showModalBottomSheet<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: activities.map(
                              (currency) {
                                return ListTile(
                                  title: Text(currency['label']!),
                                  onTap: () {
                                    Navigator.pop(context, currency['value']);
                                  },
                                );
                              },
                            ).toList(),
                          );
                        },
                      );

                      if (activityType != null) {
                        viewModel.activityTypeController.text = activityType;
                        context
                            .read<ActivityViewModel>()
                            .add(ActivitySelectEvent());
                      }
                    },
                    child: Container(
                      padding: context.paddingLow,
                      width: containerWidth,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: viewModel.activityTypeController.text.isEmpty
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Activity Type',
                                  style: context.textStyleGreyBarlow(context),
                                ),
                                const Icon(Icons.arrow_drop_down_sharp),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  viewModel.activityTypeController.text,
                                  style: context.textStyleGreyBarlow(context),
                                ),
                                const Icon(Icons.arrow_drop_down_sharp),
                              ],
                            ),
                    ),
                  ),
                ),
                context.sizedHeightBoxLower,
                Center(
                  child: SizedBox(
                    height: context.dynamicHeight(0.3),
                    width: context.dynamicWidth(0.75),
                    child: viewModel.activityTypeController.text.isNotEmpty
                        ? (() {
                            // Determine which list to use based on activityTypeController
                            List selectedList;
                            bool isRequest;

                            if (viewModel.activityTypeController.text ==
                                'All') {
                              selectedList = state.combinedFilteredList;
                              isRequest = selectedList.isNotEmpty
                                  ? (selectedList.first['status'] == 'pending')
                                  : true;
                            }
                            if (viewModel.activityTypeController.text ==
                                'Requests') {
                              selectedList = state.filteredRequestedMoney;
                              isRequest = true;
                            } else if (viewModel.activityTypeController.text ==
                                'Debts') {
                              selectedList = state.filteredOwedMoney;
                              isRequest = false;
                            } else {
                              selectedList = [];
                              isRequest =
                                  true; // Default value or you might handle this case differently
                            }

                            return selectedList.isEmpty
                                ? SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.images.svg.noActivity,
                                          height: context.dynamicHeight(0.22),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            'No Recent Activity Found',
                                            style: context
                                                .textStyleGreyBarlow(context)
                                                .copyWith(
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Scrollbar(
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: selectedList.length,
                                      itemBuilder: (context, index) {
                                        final activity = selectedList[index];
                                        final amount =
                                            activity['amount']?.toString() ??
                                                '0';
                                        final status = activity['status'];
                                        final date = activity['date'] ?? '';
                                        final friendUserId =
                                            activity['friendUserId'] ?? '';
                                        final userMessage =
                                            activity['message'] ?? '';
                                        final declineMessage =
                                            activity['declineMessage'] ?? '';
                                        final paidMessage =
                                            activity['paidMessage'] ?? '';

                                        // Fetch friend's data from state
                                        final friendData =
                                            state.friendsUserData[
                                                    friendUserId] ??
                                                {};
                                        final friendName =
                                            friendData['firstName'] ??
                                                'Unknown';
                                        final profileImageUrl =
                                            friendData['profileImageUrl'] ?? '';

                                        return Dismissible(
                                          key: Key(activity['requestId']
                                                  ?.toString() ??
                                              'unknown'), // Ensure each item has a unique key
                                          direction:
                                              DismissDirection.endToStart,
                                          onDismissed: (direction) {
                                            // Make sure to remove the item from the list and update the state
                                            context
                                                .read<ActivityViewModel>()
                                                .add(
                                                  ActivityDeleteEvent(
                                                    requestId: activity[
                                                        'requestId'], // Ensure this is the correct ID
                                                    friendUserId: friendUserId,
                                                  ),
                                                );

                                            // Here, you should also remove the item from the UI's data source if needed.
                                            // You may need to refresh the data or handle the state update accordingly.
                                          },
                                          background: Container(
                                            width: cardWidth,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                  context.normalRadius),
                                            ),
                                            alignment: Alignment.centerRight,
                                            padding: context.paddingNormal,
                                            child: const Icon(
                                              Icons.close,
                                              color: AppLightColorConstants
                                                  .bgLight,
                                              size: 32.0,
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Show the dialog on tap
                                              Widget continueButton =
                                                  TextButton(
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
                                                  "Delete",
                                                  style: TextStyle(
                                                    color:
                                                        AppLightColorConstants
                                                            .errorColor,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  // Action for the Delete button
                                                  context
                                                      .read<ActivityViewModel>()
                                                      .add(
                                                        ActivityDeleteEvent(
                                                          requestId: activity[
                                                              'requestId'], // Ensure this is the correct ID
                                                          friendUserId:
                                                              friendUserId,
                                                        ),
                                                      );
                                                  Navigator.of(context)
                                                      .pop(); // Dismiss the dialog
                                                },
                                              );
                                              // Set up the AlertDialog
                                              AlertDialog alert = AlertDialog(
                                                title: isRequest
                                                    ? Text(
                                                        "Messages",
                                                        style: context
                                                            .textStyleGreyBarlow(
                                                                context)
                                                            .copyWith(
                                                              fontWeight: FontWeight
                                                                  .bold, // Bold for the title
                                                              fontSize:
                                                                  18, // Adjust size as needed
                                                            ),
                                                      )
                                                    : Text(
                                                        "Messages",
                                                        style: context
                                                            .textStyleGreyBarlow(
                                                                context)
                                                            .copyWith(
                                                              fontWeight: FontWeight
                                                                  .bold, // Bold for the title
                                                              fontSize:
                                                                  18, // Adjust size as needed
                                                            ),
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
                                                                  "Your message:\n", // Bold only for this label
                                                              style: context
                                                                  .textStyleGreyBarlow(
                                                                      context),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "$userMessage\n\n", // Normal weight for the message
                                                              style: context
                                                                  .textStyleGrey(
                                                                      context),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "$friendName's Message:\n", // Bold only for this label
                                                              style: context
                                                                  .textStyleGreyBarlow(
                                                                      context),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "$paidMessage\n", // Normal weight for the message
                                                              style: context
                                                                  .textStyleGrey(
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
                                                              text: isRequest
                                                                  ? "Your message:\n"
                                                                  : "$friendName's Message:\n", // Bold only for this label
                                                              style: context
                                                                  .textStyleGreyBarlow(
                                                                      context),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "$userMessage\n\n", // Normal weight for the message
                                                              style: context
                                                                  .textStyleGrey(
                                                                      context),
                                                            ),
                                                            TextSpan(
                                                              text: isRequest
                                                                  ? "$friendName's Message:\n"
                                                                  : "Your message:\n", // Bold only for this label
                                                              style: context
                                                                  .textStyleGreyBarlow(
                                                                      context),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  "$declineMessage\n", // Normal weight for the message
                                                              style: context
                                                                  .textStyleGrey(
                                                                      context),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                actions: [
                                                  deleteButton,
                                                  continueButton,
                                                ],
                                              );

                                              // Show the dialog
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  context.onlyTopPaddingLow,
                                              child: Center(
                                                child: RecentActivityCard(
                                                  profileImageUrl:
                                                      profileImageUrl,
                                                  friendName: friendName,
                                                  amount: amount,
                                                  date: date,
                                                  status: status,
                                                  request: isRequest,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                          })()
                        : SizedBox(
                            height: context.dynamicHeight(0.1),
                            width: context.dynamicWidth(1),
                            child: const Center(
                              child:
                                  CircularProgressIndicator(), // Loading circle
                            ),
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
