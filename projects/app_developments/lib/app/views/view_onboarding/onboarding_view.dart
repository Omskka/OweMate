import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_state.dart';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_view_model.dart';
import 'package:app_developments/app/views/view_onboarding/widgets/onboarding_page_four_widget.dart';
import 'package:app_developments/app/views/view_onboarding/widgets/onboarding_page_one_widget.dart';
import 'package:app_developments/app/views/view_onboarding/widgets/onboarding_page_three_widget.dart';
import 'package:app_developments/app/views/view_onboarding/widgets/onboarding_page_two_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingViewModel(),
      child: BlocBuilder<OnboardingViewModel, OnboardingState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: bodyWidget(state, context),
            ),
          );
        },
      ),
    );
  }

  // Selectpage widget
  Widget bodyWidget(OnboardingState state, BuildContext context) {
    if (state.selectedPage == 1) {
      return const OnboardingPageOneWidget();
    } else if (state.selectedPage == 2) {
      return const OnboardingPageTwoWidget();
    } else if (state.selectedPage == 3) {
      return const OnboardingPageThreeWidget();
    } else if (state.selectedPage == 4) {
      return const OnboardingPageFourWidget();
    }
    return const OnboardingPageOneWidget();
  }
}
