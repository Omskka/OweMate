import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_event.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsViewModel extends Bloc<SettingsEvent, SettingsState> {
  TextEditingController feedBackController = TextEditingController();

  // Define global key
  final formKey = GlobalKey<FormState>();

  SettingsViewModel() : super(SettingsInitialState()) {
    on<SettingsInitialEvent>(_initial);
    on<SettingsSwitchEvent>(_changeSwitch);
    on<SettingsNavigateToNextPageEvent>(__navigateToNextPage);
    on<SettingsSubmitFeedbackEvent>(_submitFeedback);
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

  FutureOr<void> __navigateToNextPage(
      SettingsNavigateToNextPageEvent event, Emitter<SettingsState> emit) {
    emit(
      SettingsPageIncrementState(
        selectedPage: event.selectedPage,
        state: state,
      ),
    );
  }

  FutureOr<void> _submitFeedback(
      SettingsSubmitFeedbackEvent event, Emitter<SettingsState> emit) async {
    // Upload user feedback to firebase with a randomly generated document ID
    await FirebaseFirestore.instance.collection('feedbacks').add(
      {'userFeedback': feedBackController.text.trim()},
    );

    // Reset controller
    feedBackController.clear();
  }
}
