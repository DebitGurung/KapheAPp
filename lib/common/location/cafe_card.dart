import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/common/widgets/images/t_circular_image.dart';
import 'package:kapheapp/common/widgets/text/t_brand_title_text_with_cup_icon.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/enums.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

import '../../features/shop/models/cafe_category_model.dart';

class TCafeCard extends StatelessWidget {
  const TCafeCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.cafe,
  });

  final bool showBorder;
  final void Function()? onTap;
  final CafeCategoryModel cafe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: TCircularImage(
                isNetworkImage: cafe.image.isNotEmpty, // Use network image for Cloudinary URLs
                image: cafe.image.isNotEmpty ? cafe.image : 'assets/images/coffee_cup.png', // Fallback asset
                backgroundColor: Colors.transparent,
                overlayColor: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.black,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleTextWithCupIcon(
                    title: cafe.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    'Main Branch', // Placeholder; update if branch data is available
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
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