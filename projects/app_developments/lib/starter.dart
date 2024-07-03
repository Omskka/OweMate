import 'package:app_developments/app/app.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';




const String logLevelKey = "5";
launchApp() async {

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );

  if (kDebugMode) {
    if (kDebugMode) {
      print('LogLevel set for this flavor:$logLevelKey');
    }
  }

  if (Flavor.I.isDevelopment) {
    if (kDebugMode) {
      debugPrint('Development mode');
    }
  }
  await Hive.initFlutter();
  runApp(const App());
}
