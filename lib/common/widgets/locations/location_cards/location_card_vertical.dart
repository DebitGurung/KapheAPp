// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/styles/shadows.dart';
import 'package:kapheapp/common/widgets/cafe_location/cafe_location_text.dart';
import 'package:kapheapp/common/widgets/text/location_title_text.dart';
import 'package:kapheapp/common/widgets/text/t_brand_title_text_with_cup_icon.dart';

import '../../../../features/shop/screens/location_details/widgets/location_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../images/t_rounded_image.dart';

class TLocationCardVertical extends StatelessWidget {
  const TLocationCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => const LocationDetail()),
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
          children: [
            // Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 160, // Reduced from 180
              width: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  // Thumbnail Image
                  const TRoundedImage(
                    imageUrl: TImages.cafe1,
                    applyImageRadius: true,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

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
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems / 2),

            // Details
            const Padding(
              padding: EdgeInsets.only(left: TSizes.sm, right: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TLocationTitleText(title: 'Camilia', smallSize: true),
                  SizedBox(height: TSizes.spaceBtwItems / 4),
                  TBrandTitleTextWithCupIcon(title: 'Cafe and bar'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm, right: TSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Add Flexible to prevent overflow
                  const Flexible(
                    child: TCafeLocationText(
                      location: 'St.No 16',
                      icon: Icons.pin_drop_sharp,
                      isLarge: false, // Ensure proper size configuration
                    ),
                  ),
                  // Add spacing between elements
                  const SizedBox(width: TSizes.sm),
                  Container(
                    decoration: const BoxDecoration(
                      color: TColors.dark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRadiusMd),
                        bottomRight: Radius.circular(TSizes.productImageRadius),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: TColors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
