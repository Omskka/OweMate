abstract class SettingsEvent {
  SettingsEvent();
}

class SettingsInitialEvent extends SettingsEvent {
  SettingsInitialEvent();
}

class SettingsSwitchEvent extends SettingsEvent {
  final String eventType;
  SettingsSwitchEvent({
    required this.eventType,
  });
}
