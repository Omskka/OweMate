// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'dart:async';
import 'package:app_developments/app/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_event.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends Bloc<SettingsEvent, SettingsState> {
  TextEditingController feedBackController = TextEditingController();

  // Define global key
  final formKey = GlobalKey<FormState>();

  static const _themePreferenceKey = 'isDarkTheme';
  static const _orderPreferenceKey = 'isOrderReversed'; // Added for order

  SettingsViewModel() : super(const SettingsInitialState()) {
    on<SettingsInitialEvent>(_initial);
    on<SettingsSwitchEvent>(_changeSwitch);
    on<SettingsNavigateToNextPageEvent>(_navigateToNextPage);
    on<SettingsSubmitFeedbackEvent>(_submitFeedback);

    _loadPreferences(); // Load preferences when initialized
  }

  // Load the theme and order preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool(_themePreferenceKey) ?? false;
    final isOrderReversed =
        prefs.getBool(_orderPreferenceKey) ?? false; // Load order

    emit(
      SettingsSwitchState(
        isDarkTheme: isDarkTheme,
        isOrderReversed: isOrderReversed,
      ),
    );
  }

  // Save the theme preference to SharedPreferences
  Future<void> _saveThemePreference(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePreferenceKey, isDarkTheme);
  }

  // Save the order preference to SharedPreferences
  Future<void> _saveOrderPreference(bool isOrderReversed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_orderPreferenceKey, isOrderReversed); // Save order
  }

  FutureOr<void> _initial(
      SettingsInitialEvent event, Emitter<SettingsState> emit) {}

  FutureOr<void> _changeSwitch(
      SettingsSwitchEvent event, Emitter<SettingsState> emit) async {
    bool newThemeValue = state.isDarkTheme;
    bool newOrder = state.isOrderReversed;

    if (event.eventType == 'Appearance') {
      newThemeValue = !state.isDarkTheme;

      // Save the new theme state in shared preferences
      await _saveThemePreference(newThemeValue);
    } else if (event.eventType == 'order') {
      newOrder = !state.isOrderReversed;

      // Save the new order state in shared preference
      await _saveOrderPreference(newOrder);
    }

    // Emit the new state with updated values
    emit(
      SettingsSwitchState(
        isDarkTheme: newThemeValue,
        isOrderReversed: newOrder,
      ),
    );
    App.setTheme(event.context, newThemeValue);
  }

  FutureOr<void> _navigateToNextPage(
      SettingsNavigateToNextPageEvent event, Emitter<SettingsState> emit) {
    emit(
      SettingsPageIncrementState(
        selectedPage: event.selectedPage,
        isDarkTheme: state.isDarkTheme,
        isOrderReversed: state.isOrderReversed,
      ),
    );
  }

  FutureOr<void> _submitFeedback(
      SettingsSubmitFeedbackEvent event, Emitter<SettingsState> emit) async {
    // Upload user feedback to Firebase with a randomly generated document ID
    await FirebaseFirestore.instance.collection('feedbacks').add(
      {'userFeedback': feedBackController.text.trim()},
    );

    // Reset controller
    feedBackController.clear();
  }
}
