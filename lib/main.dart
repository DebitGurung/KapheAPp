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
import 'utils/local_storage/storage_utility.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initialize TLocalStorage FIRST
  await TLocalStorage.init();

  // Preserve splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize local storage
  await GetStorage.init();

  // Prevent duplicate Firebase initialization
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Initialize Firebase App Check
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  ).catchError((e) {
    debugPrint('App Check Error: $e');
  });

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Cloudinary
  final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  final apiKey = dotenv.env['CLOUDINARY_API_KEY'] ?? '';
  final apiSecret = dotenv.env['CLOUDINARY_API_SECRET'] ?? '';
  if (cloudName.isEmpty || apiKey.isEmpty || apiSecret.isEmpty) {
    debugPrint('Cloudinary configuration missing in .env file');
  } else {
    final cloudinary = Cloudinary.full(
      cloudName: cloudName,
      apiKey: apiKey,
      apiSecret: apiSecret,
    );
    Get.put<Cloudinary>(cloudinary);
  }

  // Remove splash screen after initialization
  FlutterNativeSplash.remove();

  // Run app
  runApp(const App());
}