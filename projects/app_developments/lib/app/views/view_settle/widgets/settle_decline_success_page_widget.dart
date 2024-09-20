import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_state.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../view_model/settle_view_model.dart';

class SettleDeclineSuccessPageWidget extends StatelessWidget {
  const SettleDeclineSuccessPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettleViewModel, SettleState>(
      builder: (context, state) {
        // Check if the current theme is dark or light
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return SingleChildScrollView(
          child: Column(
            children: [
              context.sizedHeightBoxHigh,
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: context.dynamicHeight(0.4),
                      width: context.dynamicWidth(1),
                      child: Lottie.network(
                        'https://lottie.host/8b528224-1c60-4e2a-a7d5-8e6249634ebe/m8HCH7DFk8.json',
                        repeat: true,
                        frameBuilder: (context, child, composition) {
                          if (composition == null) {
                            return Container(
                              height: context.dynamicHeight(0.4),
                              width: context.dynamicWidth(1),
                              color: Colors
                                  .transparent, // Empty container before loading
                            );
                          } else {
                            return child; // The Lottie animation
                          }
                        },
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Request Declined',
                        style: context.textStyleH1(context).copyWith(
                              fontSize: 40,
                              color: isDarkMode
                                  ? ColorThemeUtil.getBgInverseColor(context)
                                  : ColorThemeUtil.getPrimaryColor(context),
                            ),
                      ),
                    ),
                    context.sizedHeightBoxLow,
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'The request has been ',
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            TextSpan(
                              text: 'declined',
                              style: context
                                  .textStyleGreyBarlow(context)
                                  .copyWith(
                                    fontSize: 15,
                                    color: AppLightColorConstants.errorColor,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  ', and a message has\nbeen sent explaining the reason.',
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    context.sizedHeightBoxNormal,
                    context.sizedHeightBoxLower,
                    Center(
                      child: CustomContinueButton(
                        buttonText: 'Continue',
                        onPressed: () {
                          context.router.push(const DebtsViewRoute());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
