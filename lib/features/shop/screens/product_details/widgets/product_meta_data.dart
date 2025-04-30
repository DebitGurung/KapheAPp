// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/images/t_circular_image.dart';
import 'package:kapheapp/common/widgets/text/product_title_text.dart';
import 'package:kapheapp/common/widgets/text/t_brand_title_text_with_cup_icon.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../common/widgets/product_price/product_price_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.sm,
                vertical: TSizes.xs,
              ),
              child: Text(
                '25%',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.apply(color: TColors.black),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              'Rs 180',
              style: Theme.of(context).textTheme.titleLarge!.apply(
                    decoration: TextDecoration.lineThrough,
                  ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            const TProductPriceText(price: '250', isLarge: true),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        //title
        const TProductTitleText(title: 'Affagato', smallSize: true),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            const TProductTitleText(title: 'Status', smallSize: true),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text('Available', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            TCircularImage(
              image: TImages.product3,
              width: 32,
              height: 32,
              overlayColor: dark ? TColors.dark : TColors.white,
            ),
            const TBrandTitleTextWithCupIcon(
              title: 'Coffee',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
