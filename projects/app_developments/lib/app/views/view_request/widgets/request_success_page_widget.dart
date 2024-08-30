import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_request/view_model/request_state.dart';
import 'package:app_developments/app/views/view_request/view_model/request_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestSuccessPageWidget extends StatelessWidget {
  const RequestSuccessPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestViewModel, RequestState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<RequestViewModel>(context);
        // Handle the case where maxWidth or maxHeight is Infinity
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        // Define responsive variables
        double containerWidth;
        EdgeInsets leftPadding;

        // Height
        if (screenHeight <= 600) {
        } else if (screenHeight <= 800) {
        } else if (screenHeight <= 900) {
        } else if (screenHeight <= 1080) {
        } else {}

        // Width
        if (screenWidth <= 600) {
          containerWidth = 0.9;
          leftPadding = context.onlyLeftPaddingMedium;
        } else if (screenWidth <= 800) {
          containerWidth = 0.68;
          leftPadding = context.onlyLeftPaddingMedium;
        } else if (screenWidth <= 900) {
          containerWidth = 0.63;
          leftPadding = context.onlyLeftPaddingHigh * 1.5;
        } else if (screenWidth <= 1080) {
          containerWidth = 0.6;
          leftPadding = context.onlyLeftPaddingHigh * 1.7;
        } else {
          containerWidth = 0.5;
          leftPadding = context.onlyLeftPaddingHigh * 4;
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: context.onlyTopPaddingHigh,
                child: Image.asset(Assets.images.png.success.path),
              ),
              context.sizedHeightBoxLow,
              SizedBox(
                width: context.dynamicWidth(1),
                height: context.dynamicHeight(0.15),
                child: Center(
                  child: Text(
                    'Request Send\nSuccessfully',
                    style: context.textStyleH1(context).copyWith(fontSize: 35),
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Your request is pending.',
                        style: context.textStyleGrey(context).copyWith(
                              fontSize: 15,
                            ),
                      ),
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'You’ll be notified once it’s ',
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            TextSpan(
                              text: 'paid',
                              style: context
                                  .textStyleGreyBarlow(context)
                                  .copyWith(
                                    color: AppLightColorConstants.successColor,
                                    fontSize: 15,
                                  ),
                            ),
                            TextSpan(
                              text: ' or if it’s ',
                              style: context.textStyleGrey(context).copyWith(
                                    fontSize: 15,
                                  ),
                            ),
                            TextSpan(
                              text: 'declined',
                              style: context
                                  .textStyleGreyBarlow(context)
                                  .copyWith(
                                    color: AppLightColorConstants.errorColor,
                                    fontSize: 15,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              context.sizedHeightBoxNormal,
              context.sizedHeightBoxLow,
              Center(
                child: CustomContinueButton(
                  buttonText: 'Continue',
                  onPressed: () {
                    context.router.push(const HomeViewRoute());
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
