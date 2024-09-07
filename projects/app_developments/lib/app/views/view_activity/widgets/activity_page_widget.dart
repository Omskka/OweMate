import 'package:app_developments/app/views/view_activity/view_model/activity_event.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_state.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityPageWidget extends StatelessWidget {
  const ActivityPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityViewModel, ActivityState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<ActivityViewModel>(context);

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
          {'value': 'USD', 'label': 'USD (\$)'},
          {'value': 'TL', 'label': 'TL (₺)'},
          {'value': 'EURO', 'label': 'EURO (€)'},
          {'value': 'GBP', 'label': 'GBP (£)'},
          {'value': 'JPY', 'label': 'JPY (¥)'},
          {'value': 'CHF', 'label': 'CHF (₣)'},
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
        return SingleChildScrollView(
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
                            color: AppLightColorConstants.bgInverse,
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
                      color: AppLightColorConstants.primaryColor,
                      borderRadius: BorderRadius.all(context.normalRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
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
                              style:
                                  context.textStyleGreyBarlow(context).copyWith(
                                        fontSize: 17,
                                        color: AppLightColorConstants.bgLight,
                                      ),
                            ),
                          ),
                        ),

                        DropdownMenu<String>(
                          width: containerWidth,
                          menuHeight: context.dynamicHeight(0.15),
                          textStyle: context
                              .textStyleGrey(context)
                              .copyWith(
                                color: AppLightColorConstants.bgLight,
                              )
                              .copyWith(fontWeight: FontWeight.w600),
                          controller: viewModel.requestCurrencyController,
                          hintText: 'Currency',
                          dropdownMenuEntries: currencies.map(
                            (currency) {
                              return DropdownMenuEntry<String>(
                                value: currency['value']!,
                                label: currency['label']!,
                              );
                            },
                          ).toList(),
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
                                          color: AppLightColorConstants.bgLight,
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
                      color: AppLightColorConstants.thirdColor,
                      borderRadius: BorderRadius.all(context.normalRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
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
                              style:
                                  context.textStyleGreyBarlow(context).copyWith(
                                        fontSize: 17,
                                        color: AppLightColorConstants.bgLight,
                                      ),
                            ),
                          ),
                        ),

                        DropdownMenu<String>(
                          width: containerWidth,
                          menuHeight: context.dynamicHeight(0.15),
                          textStyle: context
                              .textStyleGrey(context)
                              .copyWith(
                                color: AppLightColorConstants.bgLight,
                              )
                              .copyWith(fontWeight: FontWeight.w600),
                          controller: viewModel.debtCurrencyController,
                          hintText: 'Currency',
                          dropdownMenuEntries: currencies.map(
                            (currency) {
                              return DropdownMenuEntry<String>(
                                value: currency['value']!,
                                label: currency['label']!,
                              );
                            },
                          ).toList(),
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
                                          color: AppLightColorConstants.bgLight,
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
                        color: AppLightColorConstants.contentTeritaryColor),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
