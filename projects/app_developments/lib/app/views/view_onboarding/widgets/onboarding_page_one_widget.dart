import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_event.dart';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_state.dart';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/carousel_dots.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPageOneWidget extends StatelessWidget {
  const OnboardingPageOneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingViewModel, OnboardingState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<OnboardingViewModel>(context);
        return Column(
          children: [
            SizedBox(
              height: context.dynamicHeight(0.07),
              width: context.dynamicWidth(1),
            ),
            SizedBox(
              height: context.dynamicHeight(0.43),
              width: context.dynamicWidth(1),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;
                  final maxHeight = constraints.maxHeight;

                  double leftPositionImage1;
                  double leftPositionImage2;
                  double topPositionImage2;

                  // Check screen size and adjust positions and sizes accordingly
                  if (maxWidth <= 600) {
                    // Small screens
                    leftPositionImage1 = maxWidth * 0.02;
                    leftPositionImage2 = maxWidth * 0.4;
                    topPositionImage2 = maxHeight * 0.2;
                  } else if (maxWidth <= 1200) {
                    // Medium screens
                    leftPositionImage1 = maxWidth * 0.08;
                    leftPositionImage2 = maxWidth * 0.28;
                    topPositionImage2 = maxHeight * 0.25;
                  } else {
                    // Large screens
                    leftPositionImage1 = maxWidth * 0.13;
                    leftPositionImage2 = maxWidth * 0.28;
                    topPositionImage2 = maxHeight * 0.2;
                  }

                  return Stack(
                    children: [
                      Positioned(
                        left: leftPositionImage1,
                        child: Image.asset(
                          Assets.images.png.characterQuestionMark.path,
                          width: context.dynamicWidth(0.6),
                          height: context.dynamicHeight(0.3),
                        ),
                      ),
                      Positioned(
                        left: leftPositionImage2,
                        top: topPositionImage2,
                        child: Image.asset(
                          Assets.images.png.characterThinking.path,
                          width: context.dynamicWidth(0.6),
                          height: context.dynamicHeight(0.3),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Title
            SizedBox(
              height: context.dynamicHeight(0.1),
              width: context.dynamicWidth(1),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Never Forget a Debt',
                    style: context.textStyleH2(context),
                  ),
                ),
              ),
            ),
            // Description
            SizedBox(
              height: context.dynamicHeight(0.07),
              width: context.dynamicWidth(1),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: context.textStyleGrey(context),
                      children: [
                        const TextSpan(
                          text:
                              'Keep a clear record of who owes what,\nensuring every penny is accounted for with ',
                        ),
                        TextSpan(
                          text: 'Owe',
                          style: context.textStyleGrey(context).copyWith(
                                color: AppLightColorConstants
                                    .primaryColor, // Color for "Owe"
                                fontWeight: FontWeight
                                    .bold, // Optional: Make "Owe" bold
                              ),
                        ),
                        TextSpan(
                          text: 'Mate',
                          style: context.textStyleGrey(context).copyWith(
                                color: AppLightColorConstants
                                    .ThirdColor, // Color for "Mate"
                                fontWeight: FontWeight
                                    .bold, // Optional: Make "Mate" bold
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            context.sizedHeightBoxNormal,
            // Carousel Slider
            const CarouselDots(selectedPage: 1),
            context.sizedHeightBoxNormal,
            // Custom continue Button
            CustomContinueButton(
              buttonText: 'Continue',
              onPressed: () {
                viewModel.add(
                  OnboardingNavigateToNextPageEvent(
                      selectedPage: 2, context: context),
                );
              },
            ),
            context.sizedHeightBoxLow,
            FittedBox(
              fit: BoxFit.scaleDown,
              child: GestureDetector(
                onTap: () {
                  context.router.push(const SignupViewRoute());
                },
                child: Text(
                  'Skip Introduction',
                  style: context.textStyleGreyBarlow(context).copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
