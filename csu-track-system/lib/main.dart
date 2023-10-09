import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'bindings/initial_binding.dart';
import 'firebase_options.dart';
import 'routes/app_routes.dart';

void main() async {
  // Ensure that Flutter is initialized and ready to run the app.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase and then run the app.
  await initializeFirebaseAndRunApp();
}

// Function to initialize Firebase and run the app.
Future<void> initializeFirebaseAndRunApp() async {
  // Initialize Firebase with the default options.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize dependencies using GetX bindings.
  InitialBindings().dependencies();

  // Set preferred screen orientations to portrait.
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) {
    // Run the main application widget.
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Define the pages and routes for the app.
      getPages: AppRoutes.pages(),
      
      // Disable the debug banner in the app.
      debugShowCheckedModeBanner: false,
      
      // Set the primary theme color to red.
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}
