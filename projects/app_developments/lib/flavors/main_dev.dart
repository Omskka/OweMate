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

  // Set up the environment and launch the app
  Flavor.create(
    Environment.dev,
    name: "Dev",
    color: Colors.green,
  );

  launchApp();
}
