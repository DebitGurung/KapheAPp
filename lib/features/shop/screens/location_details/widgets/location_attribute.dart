import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/common/widgets/text/location_title_text.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';

import '../../../../../common/choice_chip/choice_chip.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TLocationAttribute extends StatelessWidget {
  const TLocationAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.primaryColor : TColors.grey,
          child: const Column(
            children: [
              Row(
                children: [
                  SizedBox(width: TSizes.spaceBtwItems),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [SizedBox(width: TSizes.spaceBtwItems)]),
                      Row(
                        children: [
                          TLocationTitleText(
                            title: 'Operating hours and days',
                            smallSize: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                  //actual price
                ],
              ),
              //discount description
              TLocationTitleText(
                title: 'Tuesday to Sunday from 9 AM to 11 PM',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        //attributes
        const Column(
          children: [
            TSectionHeading(title: 'Services', showActionButton: false),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: 'Kid friendly', selected: true),
                TChoiceChip(text: 'Animal friendly', selected: true),
                TChoiceChip(text: 'Wifi', selected: true),
                TChoiceChip(text: 'Outdoors', selected: true),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
