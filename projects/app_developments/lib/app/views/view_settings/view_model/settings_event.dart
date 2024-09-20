import 'package:flutter/material.dart';

abstract class SettingsEvent {
  SettingsEvent();
}

class SettingsInitialEvent extends SettingsEvent {
  SettingsInitialEvent();
}

class SettingsSwitchEvent extends SettingsEvent {
  final String eventType;
  final BuildContext context;
  SettingsSwitchEvent({
    required this.eventType,
    required this.context,
  });
}

// Event to navigate to the next page, holds the context for navigation
class SettingsNavigateToNextPageEvent extends SettingsEvent {
  final int selectedPage;
  final BuildContext context;

  // Constructor to initialize the context
  SettingsNavigateToNextPageEvent({
    required this.context,
    required this.selectedPage,
  });
}

class SettingsSubmitFeedbackEvent extends SettingsEvent {
  final BuildContext context;
  SettingsSubmitFeedbackEvent({
    required this.context,
  });
}
