import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_state.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../view_model/settle_view_model.dart';

class SettlePaySuccessPageWidget extends StatelessWidget {
  const SettlePaySuccessPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettleViewModel, SettleState>(
      builder: (context, state) {
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
                        'https://lottie.host/a2912654-0f21-471b-b57b-03ce25e65971/krfQgBrPnS.json',
                        repeat: false,
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
                        'Marked as Paid',
                        style:
                            context.textStyleH1(context).copyWith(fontSize: 40),
                      ),
                    ),
                    context.sizedHeightBoxLow,
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Your payment has been marked as ',
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            TextSpan(
                              text: 'completed',
                              style: context
                                  .textStyleGreyBarlow(context)
                                  .copyWith(
                                    fontSize: 15,
                                    color: AppLightColorConstants.successColor,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  ', and the\nmessage has been sent to the other party.',
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
