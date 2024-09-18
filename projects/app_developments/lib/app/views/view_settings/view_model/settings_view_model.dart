import 'dart:async';

import 'package:app_developments/app/views/view_settings/view_model/settings_event.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsViewModel extends Bloc<SettingsEvent, SettingsState> {
  SettingsViewModel() : super(SettingsInitialState()) {
    on<SettingsInitialEvent>(_initial);
    on<SettingsSwitchEvent>(_changeSwitch);
  }

  FutureOr<void> _initial(
      SettingsInitialEvent event, Emitter<SettingsState> emit) {}

  FutureOr<void> _changeSwitch(
      SettingsSwitchEvent event, Emitter<SettingsState> emit) {
    // Define the variables before the conditions
    bool newThemeValue = state.isDarkTheme;
    bool newOrder = state.isOrderReversed;

    if (event.eventType == 'Appearance') {
      newThemeValue = !state.isDarkTheme;
    } else if (event.eventType == 'order') {
      newOrder = !state.isOrderReversed;
    }

    // Emit the new state with updated values
    emit(
      SettingsSwitchState(
        isDarkTheme: newThemeValue,
        isOrderReversed: newOrder,
        state: state,
      ),
    );
  }
}
