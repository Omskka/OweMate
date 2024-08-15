import 'dart:async';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_event.dart';
import 'package:app_developments/app/views/view_onboarding/view_model/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingViewModel extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingViewModel() : super(OnboardingInitialState()) {
    on<OnboardingInitialEvent>(_initial);
    on<OnboardingNavigateToNextPageEvent>(_navigateToNextPage);
  }

  FutureOr<void> _initial(
      OnboardingInitialEvent event, Emitter<OnboardingState> emit) {
    emit(OnboardingPageIncrementState(selectedPage: 0, state: state));
    // Initial setup if any
  }

  FutureOr<void> _navigateToNextPage(
      OnboardingNavigateToNextPageEvent event, Emitter<OnboardingState> emit) {
    emit(
      OnboardingPageIncrementState(
        selectedPage: event.selectedPage,
        state: state,
      ),
    );
  }
}
