import 'package:flutter/material.dart';

// Abstract base class for all settings-related events
abstract class SettingsEvent {
  SettingsEvent();
}

// Event for initializing settings
class SettingsInitialEvent extends SettingsEvent {
  SettingsInitialEvent();
}

// Event for handling switch toggles in settings, holds the event type and context
class SettingsSwitchEvent extends SettingsEvent {
  final String eventType;
  final BuildContext context;

  // Constructor to initialize the eventType and context
  SettingsSwitchEvent({
    required this.eventType,
    required this.context,
  });
}

// Event to navigate to the next page, holds the context for navigation and the selected page index
class SettingsNavigateToNextPageEvent extends SettingsEvent {
  final int selectedPage; // The index of the page to navigate to
  final BuildContext context; // The context used for navigation

  // Constructor to initialize the context and selected page index
  SettingsNavigateToNextPageEvent({
    required this.context,
    required this.selectedPage,
  });
}

// Event for submitting feedback, holds the context for submission
class SettingsSubmitFeedbackEvent extends SettingsEvent {
  final BuildContext context;

  // Constructor to initialize the context
  SettingsSubmitFeedbackEvent({
    required this.context,
  });
}

// Event for deleting the user's account, holds the context for this action
class SettingsDeleteAccountEvent extends SettingsEvent {
  final BuildContext context;

  // Constructor to initialize the context
  SettingsDeleteAccountEvent({
    required this.context,
  });
}

// Event for signing out
class SettingsSignOutEvent extends SettingsEvent {
  final BuildContext context;

  // Constructor to initialize the context
  SettingsSignOutEvent({
    required this.context,
  });
}
