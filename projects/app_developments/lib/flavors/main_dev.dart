import 'package:app_developments/starter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_developments/firebase_options.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  // Initialise Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Flavor.create(
    Environment.dev,
    name: "Dev",
    color: Colors.green,
  );
  launchApp();
}
