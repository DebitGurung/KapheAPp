// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/images/t_circular_image.dart';
import 'package:kapheapp/common/widgets/text/t_brand_title_text_with_cup_icon.dart';
import 'package:kapheapp/utils/constants/enums.dart';

import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/cafe_model.dart';

class TLocationMetaData extends StatelessWidget {
  const TLocationMetaData({super.key, required this.cafe});

  final CafeModel cafe;

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
              backgroundColor: TColors.primaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.sm,
                vertical: TSizes.xs,
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        Row(
          children: [
            TCircularImage(
              image: TImages.cafe1,
              width: 32,
              height: 32,
              overlayColor: dark ? TColors.primaryColor : TColors.white,
            ),
             TBrandTitleTextWithCupIcon(
              title: cafe.title,
              brandTextSize: TextSizes.large,
              iconColor: TColors.orange,
              textColor: TColors.orange,
            )
          ],
        )
      ],
    );
  }
}
