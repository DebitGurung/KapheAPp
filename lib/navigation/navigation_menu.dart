// File: navigation_menu.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/products/product_repository.dart';
import 'package:kapheapp/features/personalization/screens/settings/settings.dart';
import 'package:kapheapp/features/shop/controllers/product/product_controller.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';
import '../features/shop/screens/home/widgets/home.dart';
import '../features/shop/screens/store/store.dart';
import '../features/shop/screens/wishlist/wishlist.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Register dependencies
    Get.put(ProductRepository());
    Get.put(ProductController());

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
              ? TColors.white
              : TColors.black,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.store_mall_directory_outlined), label: 'Store'),
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

  List<Widget> get screens => [
    const StoreScreen(), // Cafe Screen (index 0)
    const HomeScreen(), // Home Screen (index 1)
    const FavouriteScreen(), // Wishlist Screen (index 2)
    const SettingsScreen(), // Profile Screen (index 3)
  ];
}