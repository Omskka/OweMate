abstract class SettingsState {
  bool isDarkTheme = false;
  bool isOrderReversed = false;
  SettingsState({
    required this.isDarkTheme,
    required this.isOrderReversed,
  });
}

class SettingsInitialState extends SettingsState {
  SettingsInitialState()
      : super(
          isDarkTheme: false,
          isOrderReversed: false,
        );
}

class SettingsSwitchState extends SettingsState {
  final SettingsState state;
  final bool isDarkTheme;
  final bool isOrderReversed;
  SettingsSwitchState({
    required this.isDarkTheme,
    required this.isOrderReversed,
    required this.state,
  }) : super(
          isDarkTheme: isDarkTheme,
          isOrderReversed: isOrderReversed,
        );
}
