// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _themePreferenceKey = 'isDarkTheme';
  static const _orderPreferenceKey = 'isOrderReversed';

  Future<bool> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themePreferenceKey) ?? false;
  }

  Future<bool> loadOrderPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_orderPreferenceKey) ?? false;
  }

  Future<void> saveThemePreference(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePreferenceKey, isDarkTheme);
  }

  Future<void> saveOrderPreference(bool isOrderReversed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_orderPreferenceKey, isOrderReversed);
  }
}
