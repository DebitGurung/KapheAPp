import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/brand/brand_products.dart';
import 'package:kapheapp/utils/effect/shimmer.dart';

import '../../features/shop/brand/brand_card.dart';
import '../../features/shop/models/brand_model.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';
import '../widgets/custom_shapes/rounded_container.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key,
    required this.images,
    required this.brand,

  });

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: TRoundedContainer(
        showBorder: true,
        borderColor: TColors.darkerGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            TBrandCard(showBorder: false, brand: brand),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image,context)).toList()
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image,  context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(TSizes.md),
        margin:  const EdgeInsets.only(right: TSizes.sm),
        backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
        child:  CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: image,
        progressIndicatorBuilder: (context, url, downloadProgress) => const TShimmerEffect(width: 100, height: 100),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}