import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_state.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtsPageWidget extends StatelessWidget {
  const DebtsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtsViewModel, DebtsState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;

            // Determine height and width based on screen width
            double containerHeight;
            double containerWidth;

            // Height
            if (maxHeight <= 600) {
              containerHeight = context.dynamicHeight(0.08);
            } else if (maxHeight <= 800) {
              containerHeight = context.dynamicHeight(0.08);
            } else if (maxHeight <= 900) {
              containerHeight = context.dynamicHeight(0.08);
            } else if (maxHeight <= 1080) {
              containerHeight = context.dynamicHeight(0.08);
            } else {
              containerHeight = context.dynamicHeight(0.08);
            }

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

            return SingleChildScrollView(
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
                  context.sizedHeightBoxNormal,
                  context.sizedHeightBoxLower,
                  SizedBox(
                    height: context.dynamicHeight(0.16),
                    width: context.dynamicWidth(1),
                    child: Column(
                      children: [
                        // Title
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Money Request',
                            style: context.textStyleGrey(context).copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppLightColorConstants.primaryColor,
                                ),
                          ),
                        ),
                        context.sizedHeightBoxLower,
                        // Description
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Quickly send payment requests to friends or family,\nensuring everyone is on the same page and payments\nare made on time.',
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
                    child: GestureDetector(
                      onTap: () {
                        context.router.push(const RequestViewRoute());
                      },
                      child: Container(
                        height: containerHeight,
                        width: containerWidth,
                        decoration: BoxDecoration(
                          color: AppLightColorConstants.infoColor,
                          borderRadius: BorderRadius.all(context.normalRadius),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.2), // Shadow color
                              spreadRadius: 1, // Spread radius
                              blurRadius: 3, // Blur radius
                              offset: const Offset(
                                  0, 0.5), // Offset in x and y direction
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min, // Shrink Row to fit content
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center content within Row
                            children: [
                              context.sizedHeightBoxLow,
                              Text(
                                'Request Money',
                                style: context.textStyleGrey(context).copyWith(
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
                        // Title
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Settle Debts',
                            style: context.textStyleGrey(context).copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppLightColorConstants.primaryColor,
                                ),
                          ),
                        ),
                        context.sizedHeightBoxLower,
                        // Description
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
                    child: GestureDetector(
                      onTap: () {
                        context.router.push(const SettleViewRoute());
                      },
                      child: Container(
                        height: containerHeight,
                        width: containerWidth,
                        decoration: BoxDecoration(
                          color: AppLightColorConstants.infoColor,
                          borderRadius: BorderRadius.all(context.normalRadius),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.2), // Shadow color
                              spreadRadius: 1, // Spread radius
                              blurRadius: 3, // Blur radius
                              offset: const Offset(
                                  0, 0.5), // Offset in x and y direction
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize:
                                MainAxisSize.min, // Shrink Row to fit content
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center content within Row
                            children: [
                              context.sizedHeightBoxLower,
                              Text(
                                'Settle Debts',
                                style: context.textStyleGrey(context).copyWith(
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
            );
          },
        );
      },
    );
  }
}
