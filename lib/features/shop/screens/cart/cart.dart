import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/common/widgets/loaders/animation_loader.dart';
import 'package:kapheapp/features/shop/controllers/product/cart_controller.dart';
import 'package:kapheapp/features/shop/screens/cart/widgets/cart_items.dart';

import '../../../../navigation/navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Scaffold(
      appBar: TAppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Obx(() {
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Sorry the cart is empty.',
          animation: TImages.emptyWishlist,
          showAction: true,
          actionText: 'Add drinks.',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );
        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return SingleChildScrollView(
            child: const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),

              //items in cart
              child: TCartItems(),
            ),
          );
        }
      }),
      //checkout button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(() =>
                    Text('Checkout Rs${controller.totalCartPrice.value}')),
              ),
            ),
    );
  }
}
