import 'package:flutter/material.dart';

// Base class for all onboarding events
abstract class OnboardingEvent {}

// Event to signify the initial state of the onboarding process
class OnboardingInitialEvent extends OnboardingEvent {}

// Event to navigate to the next page, holds the context for navigation
class OnboardingNavigateToNextPageEvent extends OnboardingEvent {
  final int selectedPage;
  final BuildContext context;

  // Constructor to initialize the context
  OnboardingNavigateToNextPageEvent({
    required this.context,
    required this.selectedPage,
  });
}
