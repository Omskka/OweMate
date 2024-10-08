import 'package:flutter/material.dart';

@immutable
final class AppLightColorConstants {
  const AppLightColorConstants._();

  //base color
  static const Color primaryColor = Color(0xFF004AAD);
  static const Color secondaryColor = Color(0xFF8edfeb);
  static const Color thirdColor = Color(0xFFFF3131);
  static const Color hueShadow = Color(0xFF00BF63);
  static const Color errorColor = Color(0xFFF44336);
  static const Color successColor = Color(0xFF43A048);
  static const Color warningColor = Color(0xffFB8A00);
  static const Color infoColor = Color(0xFFE9ECEF);
  static const Color drawerColor = Color(0xFFFFFFFF);

  //button color

  static const Color buttonPrimaryColor = Color(0xFF304FFE);
  static const Color buttonDisabledColor = Color(0xFFB8B8B8);
  static const Color buttonErrorColor = Color(0xFFF44336);
  //background color

  static const Color bgLight = Color(0xFFFFFFFF);
  static const Color bgDark = Color(0xC2EEEDED);
  static const Color bgInverse = Color(0xFF121212);
  static const Color bgAccent = Color(0xFF304FFE);
  static const Color bgSecondary = Color(0xFFFDD835);
  static const Color bgError = Color(0xfff44336);
  static const Color bgSuccess = Color(0xff43A048);
  static const Color bgWarning = Color(0xFFFB8A00);
  static const Color bgAccentLight = Color(0xffEAEBFF);
  static const Color bgSecondaryLight = Color(0xFFFFF9C4);
  static const Color bgErrorLight = Color(0xFFFFEBEE);
  static const Color bgSuccessLight = Color(0xFFE8F5E9);
  static const Color bgWarningLight = Color(0xFFFFF3E0);

  //text and icon color
  static const Color contentPrimary = Color(0xFF111111);
  static const Color contentTeritaryColor = Color(0xFF5A5A5A);
  static const Color contentGreyColor = Color(0xFF5A5A5A);
  static const Color contentDisabled = Color(0xFFB8B8B8);
  static const Color debtAmountTextColor = Color(0xFFFF3131);
  static const Color requestAmountTextColor = Color(0xFF004AAD);

  //custom icon and text color
  static const Color primaryIconColor = Color(0xff444444);
  static const Color textFormFieldIconColor = Color(0xFFC9C9C9);

  //border color

  static const Color border = Color(0xFFD0D0D0);
  static const Color borderAccent = Color(0xFF576CFF);
  static const Color borderError = Color(0xFFF44336);
  static const Color borderSuccess = Color(0xFF66BB6B);
  static const Color borderWarning = Color(0xFFFFA525);

  //divider color
  static const Color divider = Color(0xFFE8E8E8);
  static const Color dividerAccent = Color(0xFFC9CCFF);
  static const Color dividerError = Color(0xFFFFCDD2);
  static const Color dividerSuccess = Color(0xFFC8E6C9);
  static const Color dividerWarning = Color(0xFFFFF3E0);

  // custom dividerColor
  static const Color dividerColor = Color(0xFFD0D0D0);

  //TextInputBorder
  static const Color textInputBorderColor = Color(0xFFb8b8b8);

  // Card colors
  static const Color moneyCardColor = Color(0xFFFFFFFF);
  static const Color financeCardColor = Color(0xFFE9ECEF);
  static const Color messageCardColor = Color(0xC2EEEDED);
}
