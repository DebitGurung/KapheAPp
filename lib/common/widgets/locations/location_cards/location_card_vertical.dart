import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/styles/shadows.dart';
import 'package:kapheapp/common/widgets/cafe_location/cafe_location_text.dart';
import 'package:kapheapp/common/widgets/text/location_title_text.dart';
import 'package:kapheapp/common/widgets/text/t_brand_title_text_with_cup_icon.dart';
import 'package:kapheapp/features/shop/models/cafe_model.dart';

import '../../../../features/shop/screens/location_details/widgets/location_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../images/t_rounded_image.dart';
import '../../../../features/shop/models/cafe_category_model.dart';

class TLocationCardVertical extends StatelessWidget {
  const TLocationCardVertical({super.key, required this.cafeModel, required CafeCategoryModel cafe});

  final CafeModel cafeModel;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => LocationDetail(cafe: cafeModel)),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            // Thumbnail Section
            _buildThumbnail(dark),

            // Details Section
            _buildLocationDetails(),

            // Location & Action Section
            _buildLocationActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(bool dark) {
    return TRoundedContainer(
      height: 160,
      padding: const EdgeInsets.all(TSizes.sm),
      backgroundColor: dark ? TColors.dark : TColors.light,
      child: Stack(
        children: [
          // Main Image
          TRoundedImage(
            imageUrl: cafeModel.thumbnail,
            applyImageRadius: true,
          ),

          // Rating Badge
          Positioned(
            top: TSizes.sm,
            left: TSizes.sm,
            child: TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.primaryBackground,
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.sm,
                vertical: TSizes.xs,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDetails() {
    return Padding(
      padding: const EdgeInsets.all(TSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TLocationTitleText(title: cafeModel.title),
          const SizedBox(height: TSizes.spaceBtwItems / 4),
          const TBrandTitleTextWithCupIcon(title: 'Cafe & Bar'),
        ],
      ),
    );
  }

  Widget _buildLocationActionBar() {
    return Padding(
      padding: const EdgeInsets.all(TSizes.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TCafeLocationText(
              location: cafeModel.address, // Use real address from model
              icon: Icons.location_pin,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => _handleSaveLocation(),
          ),
        ],
      ),
    );
  }

  void _handleSaveLocation() {
    // Implement save logic
  }
}