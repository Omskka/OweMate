import 'package:app_developments/starter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_developments/firebase_options.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main(List<String> args) async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get screen height in logical pixels
  final screenHeight = WidgetsBinding.instance.window.physicalSize.height /
      WidgetsBinding.instance.window.devicePixelRatio;

  // Check the screen height and set orientation accordingly
  if (screenHeight < 1030) {
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

  // Set up the environment and launch the app
  Flavor.create(
    Environment.dev,
    name: "Dev",
    color: Colors.green,
  );

  launchApp();
}
