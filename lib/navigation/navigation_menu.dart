// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/personalization/screens/settings/settings.dart';
import 'package:kapheapp/utils/constants/colors.dart'; // Add this import
import 'package:kapheapp/utils/helpers/helper_functions.dart';

import '../features/shop/screens/home/widgets/home.dart';
import '../features/shop/screens/store/store.dart';
import '../features/shop/screens/wishlist/wishlist.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark ? TColors.black : Colors.white,
          indicatorColor: dark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.map_outlined), label: 'Cafe'),
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.favorite_border), label: 'Wishlist'),
            NavigationDestination(
                icon: Icon(Icons.account_box_rounded), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  // Fixed screen order to match navigation destinations
  List<Widget> get screens => [
        const StoreScreen(), // Cafe Screen (index 0)
        const HomeScreen(), // Home Screen (index 1)
        const FavouriteScreen(), // Wishlist Screen (index 2)
        const SettingsScreen(), // Profile Screen (index 3)
      ];
}
