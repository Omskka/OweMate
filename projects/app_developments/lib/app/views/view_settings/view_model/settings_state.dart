abstract class SettingsState {
  final bool isDarkTheme;
  final bool isOrderReversed;
  final int? selectedPage;

  const SettingsState({
    required this.isDarkTheme,
    required this.isOrderReversed,
    this.selectedPage,
  });
}

class SettingsInitialState extends SettingsState {
  const SettingsInitialState()
      : super(
          isDarkTheme: false,
          isOrderReversed: false,
          selectedPage: 0,
        );
}

class SettingsSwitchState extends SettingsState {
  const SettingsSwitchState({
    required bool isDarkTheme,
    required bool isOrderReversed,
    int? selectedPage,
  }) : super(
          isDarkTheme: isDarkTheme,
          isOrderReversed: isOrderReversed,
          selectedPage: selectedPage,
        );
}

// State for incrementing the selected page
class SettingsPageIncrementState extends SettingsState {
  const SettingsPageIncrementState({
    int? selectedPage,
    required bool isDarkTheme,
    required bool isOrderReversed,
  }) : super(
          isDarkTheme: isDarkTheme,
          isOrderReversed: isOrderReversed,
          selectedPage: selectedPage,
        );
}
