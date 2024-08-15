import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CustomFlutterToast {
  final BuildContext context;
  final String msg;
  final Color backgroundColor;
  final Color textColor;
  final ToastGravity gravity;
  final int timeInSecForIosWeb;
  final double fontSize;

  CustomFlutterToast({
    required this.context,
    required this.msg,
    this.backgroundColor = AppLightColorConstants.buttonErrorColor,
    this.textColor = AppLightColorConstants.bgLight,
    this.gravity = ToastGravity.BOTTOM,
    this.timeInSecForIosWeb = 1,
    this.fontSize = 16.0,
  });

  void flutterToast() {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
