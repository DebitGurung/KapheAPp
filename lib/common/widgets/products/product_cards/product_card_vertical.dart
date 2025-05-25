// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/styles/shadows.dart';
import 'package:kapheapp/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:kapheapp/common/widgets/text/t_brand_title_text_with_cup_icon.dart';
import 'package:kapheapp/features/shop/controllers/product/product_controller.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/product_detail.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/enums.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/common/widgets/product_price/product_price_text.dart';
import 'package:kapheapp/common/widgets/text/product_title_text.dart';


class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final discountPercentage = controller.calculateDiscountPercentage(
        product.price, product.discount);
    final dark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Section
            TRoundedContainer(
              height: 160,
              width: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  // Product Image with fallback
                  ClipRRect(
                    borderRadius: BorderRadius.circular(TSizes.productImageRadius),
                    child: Image.network(
                      product.thumbnail.isNotEmpty
                          ? product.thumbnail
                          : 'https://via.placeholder.com/150', // Fallback image
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error_outline, color: Colors.red),
                    ),
                  ),
                  // Discount Badge
                  if (discountPercentage != null)
                    Positioned(
                      top: 12,
                      left: 0,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondaryColor.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm,
                          vertical: TSizes.xs,
                        ),
                        child: Text(
                          '$discountPercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                            color: TColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  // Favourite Icon
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(productId: product.id),
                  ),
                ],
              ),
            ),
            // Product Details (unchanged)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.sm,
                vertical: TSizes.sm,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    TProductTitleText(
                      title: product.title,
                      smallSize: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 4),
                    // Brand Name
                    if (product.brandId != null)
                      TBrandTitleTextWithCupIcon(
                        title: product.brandId!.name,
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
            ),
            // Price Section (unchanged)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.beverageType == BeverageType.single.toString() &&
                      product.discount > 0)
                    Text(
                      'Rs${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: TColors.error,
                      ),
                    ),
                  TProductPriceText(
                    price: controller.getProductPrice(product).toString(),
                    isLarge: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}