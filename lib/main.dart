// ignore_for_file: depend_on_referenced_packages

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async {
  //ensure flutter bindings are initialized
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //preserve splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //initialize local storage
  await GetStorage.init();

  // Prevent duplicate Firebase initialization robust firebase initialization
  try {
    final defaultAppExists = Firebase.apps.any((app) => app.name == '[DEFAULT]');
    if (!defaultAppExists) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      Firebase.app(); // Sync with native instance
    } else {
      debugPrint('Firebase Error: ${e.message}');
    }
  }
  //initialize firebase app check
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  //load environment variable
  await dotenv.load(fileName: ".env");

  //initialize cloudinary
  final cloudinary = Cloudinary.full(
    cloudName: dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '',
    apiKey: dotenv.env['CLOUDINARY_API_KEY'] ?? '',
    apiSecret: dotenv.env['CLOUDINARY_API_SECRET'] ?? '',
  );

  //register dependencies
  Get.put<Cloudinary>(cloudinary);

  //remove splash screen after initialization
  FlutterNativeSplash.remove();
  //run app
  runApp(const App());
}
