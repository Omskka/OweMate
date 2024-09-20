import 'package:app_developments/app/app.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_view_model.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

const String logLevelKey = "5";
launchApp(BlocProvider<dynamic> blocProvider) async {
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

  // Wrap the App in a BlocProvider to provide SettingsViewModel
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SettingsViewModel>(
          create: (context) => SettingsViewModel(),
        ),
      ],
      child: const App(),
    ),
  );
}
