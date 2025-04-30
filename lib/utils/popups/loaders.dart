// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

class TLoader {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
          elevation: 0,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: THelperFunctions.isDarkMode(Get.context!)
                  ? TColors.darkGrey
                  : TColors.grey,
            ),
            child: Center(
                child: Text(message,
                    style: Theme.of(Get.context!).textTheme.labelLarge)),
          )),
    );
  }

  // Success Snackbar
  static void successSnackBar({
    required String title,
    String message = '',
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: TColors.primaryColor,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.check_circle_outline, color: TColors.white),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      borderRadius: 8,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  // Warning Snackbar
  static void warningSnackBar({
    required String title,
    String message = '',
    int duration = 4,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: TColors.orange,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.warning_amber_rounded, color: TColors.white),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      borderRadius: 8,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  // Error Snack bar (New)
  static void errorSnackBar({
    required String title,
    String message = '',
    int duration = 5,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: TColors.white,
      backgroundColor: TColors.error,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.error_outline, color: TColors.white),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      borderRadius: 8,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  // Loading Dialog (New)
  static void showLoadingDialog({
    String title = 'Processing...',
    String message = 'Please wait',
    bool dismissible = false,
  }) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => dismissible,
        child: AlertDialog(
          title: Text(title),
          content: Row(
            children: [
              const CircularProgressIndicator(color: TColors.primaryColor),
              const SizedBox(width: 20),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      ),
      barrierDismissible: dismissible,
    );
  }

  // Close Loading Dialog (New)
  static void closeLoadingDialog() {
    if (Get.isDialogOpen!) Get.back();
  }
}
