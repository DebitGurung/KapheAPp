import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/icons/t_circular_icon.dart';
import 'package:kapheapp/features/shop/controllers/product/cart_controller.dart';
import 'package:kapheapp/features/shop/controllers/product/variation_controller.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TBottomAddToCart extends StatefulWidget {
  const TBottomAddToCart({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  TBottomAddToCartState createState() => TBottomAddToCartState();
}

class TBottomAddToCartState extends State<TBottomAddToCart> {
  late final CartController cartController;
  late final VariationController variationController;

  @override
  void initState() {
    super.initState();
    cartController = CartController.instance;
    variationController = VariationController.instance;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.updateAlreadyAddedProductCount(widget.product);
      // Removed print statement
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final isVariable = widget.product.beverageType == 'variable';

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Obx(() {
        final isInStock = widget.product.availabilityStatus.toLowerCase().contains('in stock') ||
            widget.product.availabilityStatus.toLowerCase().contains('available');
        final maxStock = isVariable
            ? (variationController.selectedVariation.value.id.isNotEmpty
            ? variationController.selectedVariation.value.stock
            : 0)
            : (isInStock ? 9999 : 0);
        final currentQuantity = cartController.productQuantityInCart.value;
        final canDecrease = currentQuantity > 0;
        final canIncrease = currentQuantity < maxStock && maxStock > 0;
        final isVariationSelected = !isVariable || variationController.selectedVariation.value.id.isNotEmpty;

        // Removed print statement
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularIcon(
                  icon: Icons.remove,
                  backgroundColor: TColors.orange,
                  width: 40,
                  height: 40,
                  color: canDecrease ? TColors.orange : TColors.white,
                  onPressed: canDecrease
                      ? () {
                    cartController.productQuantityInCart.value -= 1;
                    cartController.updateCart();
                  }
                      : null,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(
                  currentQuantity.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                TCircularIcon(
                  icon: Icons.add,
                  backgroundColor: TColors.orange,
                  width: 40,
                  height: 40,
                  color: canIncrease ? TColors.orange : TColors.white,
                  onPressed: canIncrease
                      ? () {
                    cartController.productQuantityInCart.value += 1;
                    cartController.updateCart();
                  }
                      : null,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: (currentQuantity > 0 && isVariationSelected)
                  ? () {
                cartController.addToCart(widget.product);
                cartController.updateAlreadyAddedProductCount(widget.product);
              }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.orange,
                side: const BorderSide(color: TColors.black),
              ),
              child: const Text('Add to cart'),
            ),
          ],
        );
      }),
    );
  }
}