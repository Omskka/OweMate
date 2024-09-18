abstract class SettingsState {
  bool isDarkTheme = false;
  bool isOrderReversed = false;
  final int? selectedPage;

  SettingsState({
    required this.isDarkTheme,
    required this.isOrderReversed,
    this.selectedPage,
  });
}

class SettingsInitialState extends SettingsState {
  SettingsInitialState()
      : super(
          isDarkTheme: false,
          isOrderReversed: false,
          selectedPage: 0,
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

// State for incrementing the selected page
class SettingsPageIncrementState extends SettingsState {
  final int? selectedPage;
  final SettingsState state;
  SettingsPageIncrementState({
    this.selectedPage,
    required this.state,
  }) : super(
          isOrderReversed: state.isOrderReversed,
          isDarkTheme: state.isDarkTheme,
          selectedPage: selectedPage,
        );
}
