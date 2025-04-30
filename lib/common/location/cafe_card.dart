import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/common/widgets/images/t_circular_image.dart';
import 'package:kapheapp/common/widgets/text/t_brand_title_text_with_cup_icon.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/enums.dart';
import 'package:kapheapp/utils/constants/image_strings.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

class TCafeCard extends StatelessWidget {
  const TCafeCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

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
                isNetworkImage: false,
                image: TImages.coffeeCup,
                backgroundColor: Colors.transparent,
                overlayColor: THelperFunctions.isDarkMode(context)
                    ? TColors.white
                    : TColors.black,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TBrandTitleTextWithCupIcon(
                  title: 'Camilia',
                  brandTextSize: TextSizes.large,
                ),
                Text(
                  'Branch 1',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
