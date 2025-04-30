// import 'package:flutter/material.dart';
// ignore_for_file: library_prefixes

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kapheapp/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
//update current page index
  void updatePageIndicator(index) => currentPageIndex.value = index;
//jump to index specific dot navigation
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

//update current index and jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      if (kDebugMode) {
        print('========get storage next button=======');
        print(storage.read('IsFirstTime')); // Use 'storage' not 'deviceStorage'
      }

      storage.write('IsFirstTime', false);
      if (kDebugMode) {
        print('========get storage next button=======');
        print(storage.read('IsFirstTime')); // Remove invalid 'as Uri' cast
      }
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

//update current index and jump to last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
