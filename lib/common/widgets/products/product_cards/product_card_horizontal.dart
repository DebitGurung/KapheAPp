// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/common/widgets/images/t_rounded_image.dart';
import 'package:kapheapp/common/widgets/product_price/product_price_text.dart';
import 'package:kapheapp/common/widgets/products/favourite_icon/favourite_icon.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../text/product_title_text.dart';
import '../../text/t_brand_title_text_with_cup_icon.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({
    super.key,
    required this.product,});


  //variable
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final discountPercentage = controller.calculateDiscountPercentage(product.price, product.discount);
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.softGrey,
      ),
      child: Row(
        children: [
          //thumbnail
          TRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                   SizedBox(
                    width: 120,
                    height: 120,
                    child: TRoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),

                  //discount tag
                  if(discountPercentage != null)
                  // Sale Tag
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondaryColor.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm,
                          vertical: TSizes.xs,
                        ),
                        child: Text(
                          '$discountPercentage%',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.apply(color: TColors.white),
                        ),
                      ),
                    ),

                   Positioned(
                      top: 0,
                      right: 0,
                      child: TFavouriteIcon(productId: product.id)),
                ],
              )),

          //details, add to cart and pricing
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(
                top: TSizes.sm,
                left: TSizes.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(title: product.title, smallSize: true),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      TBrandTitleTextWithCupIcon(title: product.brandId!.name),
                    ],
                  ),
                  const Spacer(),
                  // Price row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      Flexible(
                        child: Column(
                          children: [
                            if(product.beverageType == BeverageType.single.toString() && product.discount > 0)

                              Padding(
                                padding: const EdgeInsets.only(left: TSizes.sm),
                                child: Text(
                                  product.price.toString(),
                                  style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                                ),
                              ),

                            Padding(
                              padding: const EdgeInsets.only(left: TSizes.sm),
                              child: TProductPriceText(price: controller.getProductPrice(product)),
                            ),
                          ],
                        ),
                      ),


                      //add to cart button
                      Container(
                          decoration: const BoxDecoration(
                            color: TColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(TSizes.cardRadiusMd),
                              bottomRight: Radius.circular(TSizes.productImageRadius),
                            ),
                          ),
                          child: const SizedBox(
                            width: TSizes.iconLg * 1.2,
                            height: TSizes.iconLg * 1.2,
                            child: Center(child: Icon(Icons.add, color: TColors.white)),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
