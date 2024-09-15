// ignore_for_file: use_build_context_synchronously

import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_statistics/view_model/statistics_event.dart';
import 'package:app_developments/app/views/view_statistics/view_model/statistics_state.dart';
import 'package:app_developments/app/views/view_statistics/view_model/statistics_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class StatisticsPageWidget extends StatelessWidget {
  const StatisticsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsViewModel, StatisticsState>(
      builder: (context, state) {
        // Get screen height and width using MediaQuery
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Define responsive variables
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
          containerWidth = 0.4;
        } else if (screenWidth <= 800) {
          // Small screens
          containerWidth = 0.35;
        } else if (screenWidth <= 900) {
          // Medium screens
          containerWidth = 0.35;
        } else if (screenWidth <= 1080) {
          // Medium Large screens
          containerWidth = 0.25;
        } else {
          // Large screens
          containerWidth = 0.15;
        }

        final filteredOwedMoneyLen = state.filteredOwedMoney.length;
        final filteredRequestedMoneyLen = state.filteredRequestedMoney.length;
        final int totalLen = filteredRequestedMoneyLen + filteredOwedMoneyLen;

        // Calculate percentages
        final double owedMoneyPercentage =
            (filteredOwedMoneyLen / totalLen) * 100;
        final double requestedMoneyPercentage =
            (filteredRequestedMoneyLen / totalLen) * 100;

        // Format the percentages to two decimal places
        final String formattedOwedMoneyPercentage =
            owedMoneyPercentage.toStringAsFixed(2);
        final String formattedRequestedMoneyPercentage =
            requestedMoneyPercentage.toStringAsFixed(2);

        return RefreshIndicator(
          color: AppLightColorConstants.primaryColor,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            // Dispatch the initial event to refresh the data
            context.read<StatisticsViewModel>().add(StatisticsInitialEvent());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackButtonWithTitle(
                  title: 'Statistics',
                  ontap: () {
                    context.router.push(const HomeViewRoute());
                  },
                ),
                context.sizedHeightBoxLower,
                SizedBox(
                  height: context.dynamicHeight(0.05),
                  width: context.dynamicWidth(1),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Debt to Request Ratio',
                      style: context
                          .textStyleGreyBarlow(context)
                          .copyWith(fontSize: 17),
                    ),
                  ),
                ),
                context.sizedHeightBoxLower,
                formattedRequestedMoneyPercentage != 'NaN' &&
                        formattedOwedMoneyPercentage != 'NaN'
                    ? SizedBox(
                        height: context.dynamicHeight(0.23),
                        width: context.dynamicWidth(1),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Center of the pie chart
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$formattedRequestedMoneyPercentage%', // Use the formatted string here
                                  style: context
                                      .textStyleGrey(context)
                                      .copyWith(
                                        color:
                                            AppLightColorConstants.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                context.sizedHeightBoxLower,
                                Text(
                                  '$formattedOwedMoneyPercentage%', // Use the formatted string here
                                  style: context
                                      .textStyleGrey(context)
                                      .copyWith(
                                        color:
                                            AppLightColorConstants.thirdColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            // Pie chart
                            PieChart(
                              swapAnimationDuration:
                                  const Duration(milliseconds: 750),
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    titleStyle: context
                                        .textStyleGreyBarlow(context)
                                        .copyWith(
                                          color: AppLightColorConstants.bgLight,
                                        ),
                                    value: filteredRequestedMoneyLen.toDouble(),
                                    color: AppLightColorConstants.primaryColor
                                        .withOpacity(0.8),
                                  ),
                                  PieChartSectionData(
                                    titleStyle: context
                                        .textStyleGreyBarlow(context)
                                        .copyWith(
                                          color: AppLightColorConstants.bgLight,
                                        ),
                                    value: filteredOwedMoneyLen.toDouble(),
                                    color: AppLightColorConstants.thirdColor
                                        .withOpacity(0.8),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: context.dynamicHeight(0.28),
                        width: context.dynamicWidth(1),
                        child: FutureBuilder(
                          future: Future.delayed(
                            const Duration(milliseconds: 900),
                          ), // Half a second delay
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppLightColorConstants.primaryColor,
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  SvgPicture.asset(
                                    Assets.images.svg.emptyInbox,
                                    height: context.dynamicHeight(0.22),
                                  ),
                                  Text(
                                    'Your requests and debts are currently empty.\nAdd some to see the chart.',
                                    style: context.textStyleGreyBarlow(context),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                context.sizedHeightBoxLow,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: context.dynamicHeight(0.1),
                      width: context.dynamicWidth(containerWidth),
                      decoration: BoxDecoration(
                        color: AppLightColorConstants.infoColor,
                        borderRadius: BorderRadius.all(context.normalRadius),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Pending Requests',
                              style: context.textStyleGreyBarlow(context),
                            ),
                          ),
                          context.sizedHeightBoxLower,
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '$filteredRequestedMoneyLen',
                              style: context.textStyleGreyBarlow(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: context.dynamicHeight(0.1),
                      width: context.dynamicWidth(containerWidth),
                      decoration: BoxDecoration(
                        color: AppLightColorConstants.infoColor,
                        borderRadius: BorderRadius.all(context.normalRadius),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Pending Debts',
                              style: context.textStyleGreyBarlow(context),
                            ),
                          ),
                          context.sizedHeightBoxLower,
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '$filteredOwedMoneyLen',
                              style: context.textStyleGreyBarlow(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.dynamicHeight(0.045),
                  width: context.dynamicWidth(containerWidth * 2),
                  child: const Divider(
                    color: AppLightColorConstants.infoColor,
                    thickness: 3,
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.035),
                  width: context.dynamicWidth(1),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Debt & Request Breakdown',
                      style: context
                          .textStyleGreyBarlow(context)
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
                context.sizedHeightBoxLower,
                formattedRequestedMoneyPercentage != 'NaN' &&
                        formattedOwedMoneyPercentage != 'NaN'
                    ? SizedBox(
                        height: context.dynamicHeight(0.3),
                        width: context.dynamicWidth(0.95),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Scrollbar(
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Requests')),
                                DataColumn(label: Text('Debts')),
                              ],
                              rows: state.friends.map((friend) {
                                // Extract the friend's name from the map
                                final String friendName =
                                    friend['Name'] ?? 'Unknown';

                                // Extract the number of requests and debts from the friend data
                                final int numberOfRequests =
                                    friend['requests'] ?? 0;
                                final int numberOfDebts = friend['debts'] ?? 0;

                                return DataRow(cells: [
                                  DataCell(Text(
                                      friendName)), // Display the friend's name
                                  DataCell(Text(numberOfRequests
                                      .toString())), // Display requests
                                  DataCell(Text(numberOfDebts
                                      .toString())), // Display debts
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: context.dynamicHeight(0.15),
                        width: context.dynamicWidth(1),
                        child: FutureBuilder(
                            future: Future.delayed(
                              const Duration(milliseconds: 900),
                            ), // Half a second delay
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppLightColorConstants.primaryColor,
                                  ),
                                );
                              } else {
                                return FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Your request and debt lists are empty!',
                                    style: context.textStyleGrey(context),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                            }),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
