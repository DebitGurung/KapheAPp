import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/common/widgets/icons/t_circular_icon.dart';
import 'package:kapheapp/common/widgets/layouts/grid_layout.dart';
import 'package:kapheapp/common/widgets/loaders/animation_loader.dart';
import 'package:kapheapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:kapheapp/features/shop/controllers/favourite_icon/favourite_controller.dart';
import 'package:kapheapp/features/shop/screens/home/widgets/home.dart';
import 'package:kapheapp/utils/effect/vertical_product_shimmer.dart';
import 'package:kapheapp/utils/helpers/cloud_helper_functions.dart';

import '../../../../navigation/navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Icons.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child:
              Obx(
                  () => FutureBuilder(
                    future: controller.favouriteProduct(),
                    builder: (context, snapshot) {
                      final emptyWidget = TAnimationLoaderWidget(
                        text: 'Wishlist is empty...',
                        animation: TImages.emptyWishlist,
                        showAction: true,
                        actionText: 'Add drinks you want',
                        onActionPressed: () {
                          // Get the navigation controller
                          final navigationController = Get.find<NavigationController>();
                          // Switch to home screen (index 0)
                          navigationController.selectedIndex.value = 0;
                          // Close the wishlist screen
                          Get.back();
                        },
                      );
                      const loader = TVerticalProductShimmer(itemCount: 6,);

                      final widget = TCloudHelperFunctions
                          .checkMultipleRecordState(snapshot: snapshot,
                          loader: loader,
                          nothingFound: emptyWidget);
                      if (widget != null) return widget;

                      final products = snapshot.data!;
                      return TGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) =>
                              TProductCardVertical(
                                product: products[index],));
                    }
                ),
              ),

        ),
      ),
    );
  }
}
