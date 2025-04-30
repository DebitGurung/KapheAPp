import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/t_rounded_image.dart';
import '../../text/product_title_text.dart';
import '../../text/t_brand_title_text_with_cup_icon.dart';

class TVisitLocation extends StatelessWidget {
  const TVisitLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: TImages.cafe2,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TBrandTitleTextWithCupIcon(title: 'Cafe '),
            const Flexible(child:  TProductTitleText(title: 'Camilia', maxLines: 1)),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Services  ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: 'Kid friendly', style: Theme.of(context).textTheme.bodyLarge),
              TextSpan(
                  text: 'Animal friendly', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: 'Wifi', style: Theme.of(context).textTheme.bodyLarge),
            ]))
          ],
        )
      ],
    );
  }
}
