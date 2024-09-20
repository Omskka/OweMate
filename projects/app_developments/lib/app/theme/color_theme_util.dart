import 'package:flutter/material.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/constants/dark_theme_color_constants.dart';

class ColorThemeUtil {
  // Method to get color themes based on the current context
  static Color getBgDarkColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.bgDark
        : AppLightColorConstants.bgDark;
  }

  static Color getBgLightColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.bgLight
        : AppLightColorConstants.bgLight;
  }

  static Color getPrimaryColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.primaryColor
        : AppLightColorConstants.primaryColor;
  }

  static Color getSecondaryColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.secondaryColor
        : AppLightColorConstants.secondaryColor;
  }

  static Color getContentTeritaryColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.contentTeritaryColor
        : AppLightColorConstants.contentTeritaryColor;
  }

  static Color getThirdColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.thirdColor
        : AppLightColorConstants.thirdColor;
  }

  static Color getHueColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.hueShadow
        : AppLightColorConstants.hueShadow;
  }

  static Color getBgInverseColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.bgInverse
        : AppLightColorConstants.bgInverse;
  }

  static Color getContentPrimaryColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.contentPrimary
        : AppLightColorConstants.contentPrimary;
  }

  static Color getMoneyCardColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.moneyCardColor
        : AppLightColorConstants.moneyCardColor;
  }

  static Color getMoneyDebtAmountColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.debtAmountTextColor
        : AppLightColorConstants.debtAmountTextColor;
  }

  static Color getMoneyRequesttAmountColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.requestAmountTextColor
        : AppLightColorConstants.requestAmountTextColor;
  }

  static Color getFinanceCardColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.financeCardColor
        : AppLightColorConstants.financeCardColor;
  }

  static Color getDrawerColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.drawerColor
        : AppLightColorConstants.drawerColor;
  }

  static Color getMessageCardColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? AppDarkColorConstants.messageCardColor
        : AppLightColorConstants.messageCardColor;
  }

  // Add more color getters as needed
}
