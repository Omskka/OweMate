import 'package:app_developments/app/views/view_debts/view_model/debts_state.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_developments/app/views/view_debts/view_model/debts_state.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
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
              containerHeight = context.dynamicHeight(0.05);
            } else if (maxHeight <= 800) {
              containerHeight = context.dynamicHeight(0.08);
            } else if (maxHeight <= 900) {
              containerHeight = context.dynamicHeight(0.12);
            } else if (maxHeight <= 1080) {
              containerHeight = context.dynamicHeight(0.15);
            } else {
              containerHeight = context.dynamicHeight(0.18);
            }

            // Width
            if (maxWidth <= 600) {
              containerWidth = context.dynamicWidth(0.6);
            } else if (maxWidth <= 800) {
              containerWidth = context.dynamicWidth(0.65);
            } else if (maxWidth <= 900) {
              containerWidth = context.dynamicWidth(0.7);
            } else if (maxWidth <= 1080) {
              containerWidth = context.dynamicWidth(0.75);
            } else {
              containerWidth = context.dynamicWidth(0.8);
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
                          'Home',
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
                        CustomFlutterToast(
                          context: context,
                          msg: 'Under Construction',
                        ).flutterToast();
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
                          child: ListTile(
                            leading: const Icon(
                              Icons.add,
                            ),
                            title: Text(
                              'Request Money',
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
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
                        CustomFlutterToast(
                          context: context,
                          msg: 'Under Construction',
                        ).flutterToast();
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
                          child: ListTile(
                            leading: const Icon(
                              Icons.add,
                            ),
                            title: Text(
                              'Settle Debt',
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
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
      },
    );
  }
}
