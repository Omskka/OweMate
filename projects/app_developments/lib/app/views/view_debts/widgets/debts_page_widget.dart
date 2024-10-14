import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_state.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtsPageWidget extends StatelessWidget {
  const DebtsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BlocProvider.of<DebtsViewModel>(context);
    return BlocBuilder<DebtsViewModel, DebtsState>(
      builder: (context, state) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;

            double containerHeight;
            double containerWidth;

            // Height
            containerHeight =
                context.dynamicHeight(0.08); // Simplified height assignment

            // Width
            if (maxWidth <= 600) {
              containerWidth = context.dynamicWidth(0.6);
            } else if (maxWidth <= 800) {
              containerWidth = context.dynamicWidth(0.5);
            } else if (maxWidth <= 900) {
              containerWidth = context.dynamicWidth(0.5);
            } else if (maxWidth <= 1080) {
              containerWidth = context.dynamicWidth(0.4);
            } else {
              containerWidth = context.dynamicWidth(0.25);
            }

            return PopScope(
              // Corrected from PopScope to WillPopScope
              canPop: false,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0), // Added padding
                clipBehavior: Clip.none,
                child: Column(
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
                            'Finances',
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
                    context.sizedHeightBoxNormal,
                    context.sizedHeightBoxLower,
                    SizedBox(
                      height: context.dynamicHeight(0.16),
                      width: context.dynamicWidth(1),
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Money Request',
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: isDarkMode
                                        ? ColorThemeUtil.getBgInverseColor(
                                            context)
                                        : AppLightColorConstants.primaryColor,
                                  ),
                            ),
                          ),
                          context.sizedHeightBoxLower,
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Quickly send payment requests to friends or family,\nensuring everyone is on the same page.',
                              style: context.textStyleGrey(context).copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: containerHeight,
                      width: containerWidth,
                      key: viewModel.requestsKey,
                      child: GestureDetector(
                        onTap: () {
                          context.router.push(const RequestViewRoute());
                        },
                        child: Container(
                          height: containerHeight,
                          width: containerWidth,
                          decoration: BoxDecoration(
                            color: ColorThemeUtil.getFinanceCardColor(context),
                            borderRadius:
                                BorderRadius.all(context.normalRadius),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 0.5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                context.sizedHeightBoxLow,
                                Text(
                                  'Request Money',
                                  style:
                                      context.textStyleGrey(context).copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    context.sizedHeightBoxMedium,
                    SizedBox(
                      height: context.dynamicHeight(0.16),
                      width: context.dynamicWidth(1),
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Settle Debts',
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: isDarkMode
                                        ? ColorThemeUtil.getBgInverseColor(
                                            context)
                                        : AppLightColorConstants.primaryColor,
                                  ),
                            ),
                          ),
                          context.sizedHeightBoxLower,
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Easily mark debts as paid and keep your financial\nrecords up to date with just a tap.',
                              style: context.textStyleGrey(context).copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: containerHeight,
                      width: containerWidth,
                      key: viewModel.debtsKey,
                      child: GestureDetector(
                        onTap: () {
                          context.router.push(const SettleViewRoute());
                        },
                        child: Container(
                          height: containerHeight,
                          width: containerWidth,
                          decoration: BoxDecoration(
                            color: ColorThemeUtil.getFinanceCardColor(context),
                            borderRadius:
                                BorderRadius.all(context.normalRadius),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 0.5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                context.sizedHeightBoxLower,
                                Text(
                                  'Settle Debts',
                                  style:
                                      context.textStyleGrey(context).copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                ),
                              ],
                            ),
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
      },
    );
  }
}
