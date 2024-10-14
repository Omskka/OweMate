import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_event.dart';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_state.dart';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/carousel_dots.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPageThreeWidget extends StatelessWidget {
  const OnboardingPageThreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the current theme is dark or light
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<OnboardingViewModel, OnboardingState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<OnboardingViewModel>(context);
        return Column(
          children: [
            SizedBox(
              height: context.dynamicHeight(0.1),
              width: context.dynamicWidth(1),
            ),
            SizedBox(
              height: context.dynamicHeight(0.4),
              width: context.dynamicWidth(1),
              child: Center(
                child: Image.asset(
                  Assets.images.png.onlineShopping.path,
                  width: context.dynamicWidth(0.65),
                ),
              ),
            ),
            // Title
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0), // Added padding
              height: context.dynamicHeight(0.1),
              width: context.dynamicWidth(1),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Effortless Requests',
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
            SizedBox(
              height: context.dynamicHeight(0.07),
              width: context.dynamicWidth(1),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Easily request payments or remind others,\nkeeping everything clear and stress-free.',
                    style: context.textStyleGrey(context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            context.sizedHeightBoxNormal,
            // Carousel Slider
            const CarouselDots(selectedPage: 3),
            context.sizedHeightBoxNormal,
            // Custom continue Button
            CustomContinueButton(
              buttonText: 'Continue',
              onPressed: () {
                viewModel.add(
                  OnboardingNavigateToNextPageEvent(
                      selectedPage: 4, context: context),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
