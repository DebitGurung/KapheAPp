// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/common/widgets/images/t_rounded_image.dart';
import 'package:kapheapp/common/widgets/product_price/product_price_text.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/t_circular_icon.dart';
import '../../text/product_title_text.dart';
import '../../text/t_brand_title_text_with_cup_icon.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    width: 120,
                    height: 120,
                    child: TRoundedImage(
                      imageUrl: TImages.product1,
                      applyImageRadius: true,
                    ),
                  ),
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
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.white),
                      ),
                    ),
                  ),
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: TCircularIcon(
                        icon: Icons.favorite_border_outlined,
                        color: Colors.red,
                      )),
                ],
              )),
          //details
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(
                top: TSizes.sm,
                left: TSizes.sm,
              ),
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(title: 'Latte', smallSize: true),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      TBrandTitleTextWithCupIcon(title: 'Coffee'),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(child: TProductPriceText(price: '150')),

                      //Add to cart
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(TSizes.productImageRadius),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add, color: TColors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
