// Abstract class for onboarding state, defining asset, title, and description
abstract class OnboardingState {
  final int? selectedPage;

  OnboardingState({this.selectedPage});
}

// Initial state, initializing selectedPage to 0
class OnboardingInitialState extends OnboardingState {
  OnboardingInitialState() : super(selectedPage: 0);
}

// State for incrementing the selected page
class OnboardingPageIncrementState extends OnboardingState {
  final int? selectedPage;
  final OnboardingState state;

  OnboardingPageIncrementState({
    this.selectedPage,
    required this.state,
  }) : super(
          selectedPage: selectedPage,
        );
}

// State for updating title and description
class OnboardingTitleAndDescState extends OnboardingState {
  final OnboardingState state;
  final String? svgAsset;
  final String? title;
  final String? description;

  OnboardingTitleAndDescState(
      {this.svgAsset, this.title, this.description, required this.state})
      : super(
          selectedPage: state.selectedPage,
        );
}
