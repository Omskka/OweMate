import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_event.dart';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_state.dart';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_view_model.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/core/widgets/carousel_dots.dart';
import 'package:app_developments/core/widgets/custom_continue_button.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPageFourWidget extends StatelessWidget {
  const OnboardingPageFourWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingViewModel, OnboardingState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<OnboardingViewModel>(context);
        return Column(
          children: [
            SizedBox(
              height: context.dynamicHeight(0.1),
              width: context.dynamicWidth(1),
            ),
            Container(
              //color: Colors.pinkAccent,
              height: context.dynamicHeight(0.4),
              width: context.dynamicWidth(1),
              child: Center(
                child: Image.asset(
                  Assets.images.png.characterMeditating.path,
                  width: context.dynamicWidth(0.65),
                ),
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
                    'Peace of Mind',
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
                  child: Text(
                    'Say goodbye to awkward reminders and hello to a\nstress-free, peaceful way of managing who owes what.',
                    style: context.textStyleGrey(context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            context.sizedHeightBoxNormal,
            // Carousel Slider
            const CarouselDots(selectedPage: 2),
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
          ],
        );
      },
    );
  }
}
