import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(
          title: 'Payment method',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            TRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? TColors.light : TColors.white,
                padding: const EdgeInsets.all(TSizes.sm),
                child: const Image(
                  image: AssetImage(TImages.payment),
                )),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            Text(
              'Esewa',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        )
      ],
    );
  }
}
