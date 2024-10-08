import 'package:app_developments/app/app.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_view_model.dart';
import 'package:app_developments/starter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_developments/firebase_options.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main(List<String> args) async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get screen dimensions in logical pixels
  final screenSize = WidgetsBinding.instance.window.physicalSize /
      WidgetsBinding.instance.window.devicePixelRatio;
  final screenHeight = screenSize.height;
  final screenWidth = screenSize.width;

  // Check the screen height and width and set orientation accordingly
  if (screenHeight < 900 && screenWidth < 900) {
    // Force portrait mode for smaller screens
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  } else {
    // Allow both portrait and landscape for larger screens
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  Flavor.create(
    // TODO : Add your own flavor values
    Environment.production,
    name: "Production",
    color: Colors.blue,
  );

  await dotenv.load(fileName: "api.env");

  launchApp(
    BlocProvider(
      create: (context) => SettingsViewModel(),
      child: const App(), // Replace with your app widget
    ),
  );
}
