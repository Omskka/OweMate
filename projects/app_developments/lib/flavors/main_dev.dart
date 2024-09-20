import 'package:app_developments/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_developments/firebase_options.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_view_model.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  

  final screenSize = WidgetsBinding.instance.window.physicalSize /
      WidgetsBinding.instance.window.devicePixelRatio;
  final screenHeight = screenSize.height;
  final screenWidth = screenSize.width;

  if (screenHeight < 900 && screenWidth < 900) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  } else {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Flavor.create(
    Environment.dev,
    name: "Dev",
    color: Colors.green,
  );

  runApp(
    BlocProvider(
      create: (context) => SettingsViewModel(),
      child: const App(), // Replace with your app widget
    ),
  );
}
