import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/controllers/product/cart_controller.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        if (product.beverageType == 'single') {
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          // Navigate to ProductDetail for variation selection
          Get.to(() => ProductDetail(product: product));
        }
      },
      child: Obx(
            () {
          final productQuantityInCart = cartController.getProductQuantityInCart(product.id, '');
          return Container(
            decoration: BoxDecoration(
              color: productQuantityInCart > 0 ? TColors.primaryColor : TColors.dark,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(TSizes.cardRadiusMd),
                bottomRight: Radius.circular(TSizes.productImageRadius),
              ),
            ),
            child: SizedBox(
              width: TSizes.iconLg * 1.2,
              height: TSizes.iconLg * 1.2,
              child: Center(
                child: productQuantityInCart > 0
                    ? Text(
                  productQuantityInCart.toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.white),
                )
                    : const Icon(Icons.add, color: TColors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}