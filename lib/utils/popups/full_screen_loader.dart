import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

import '../../common/widgets/loaders/animation_loader.dart';
import '../constants/colors.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,//disables back button pop up
        child: Scaffold(
          backgroundColor: THelperFunctions.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          body: Center(
            child: SizedBox( // Constrain height to prevent infinite size
              width: 200, // Adjust as needed
              height: 200, // Adjust based on content
              child: TAnimationLoaderWidget(
                text: text,
                animation: animation,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}