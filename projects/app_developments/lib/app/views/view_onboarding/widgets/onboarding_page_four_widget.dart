import 'package:app_developments/app/routes/app_router.dart';
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

class OnboardingPageFourWidget extends StatelessWidget {
  const OnboardingPageFourWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingViewModel, OnboardingState>(
      builder: (context, state) {
        // Check if the current theme is dark or light
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        final viewModel = BlocProvider.of<OnboardingViewModel>(context);
        return Column(
          children: [
            SizedBox(
              height: context.dynamicHeight(0.05),
              width: context.dynamicWidth(1),
            ),
            SizedBox(
              height: context.dynamicHeight(0.45),
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
                    leftPositionImage1 = maxWidth * 0;
                    leftPositionImage2 = maxWidth * 0.38;
                    topPositionImage2 = maxHeight * 0.25;
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
                        top: topPositionImage2,
                        left: leftPositionImage1,
                        child: Image.asset(
                          Assets.images.png.saly1.path,
                          width: context.dynamicWidth(0.6),
                          height: context.dynamicHeight(0.3),
                        ),
                      ),
                      Positioned(
                        left: leftPositionImage2,
                        child: Image.asset(
                          Assets.images.png.saly2.path,
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
                    'Settle Up Quickly',
                    style: context.textStyleH2(context).copyWith(
                          color: isDarkMode
                              ? AppLightColorConstants.bgLight
                              : AppLightColorConstants.primaryColor,
                        ),
                  ),
                ),
              ),
            ),
            // Description
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0), // Added padding
              height: context.dynamicHeight(0.07),
              width: context.dynamicWidth(1),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Easily settle debts and balances with friends and family,\nfinancial interactions smooth and stress-free.',
                    style: context.textStyleGrey(context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            context.sizedHeightBoxNormal,
            // Carousel Slider
            const CarouselDots(selectedPage: 4),
            context.sizedHeightBoxNormal,
            // Custom continue Button
            CustomContinueButton(
              buttonText: 'Continue',
              onPressed: () {
                context.router.push(const LoginViewRoute());
              },
            ),
          ],
        );
      },
    );
  }
}
