import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/common/widgets/product_price/product_price_text.dart';
import 'package:kapheapp/common/widgets/text/product_title_text.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';

import '../../../../../common/choice_chip/choice_chip.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TProductAttribute extends StatelessWidget {
  const TProductAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  const TSectionHeading(
                    title: 'Offers',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Price',
                            smallSize: true,
                          ),
                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          Text(
                            'Rs 180',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          //discount price
                          const TProductPriceText(price: '110')
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(
                            title: 'Status',
                            smallSize: true,
                          ),
                          Text(
                            'Available',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                  //actual price
                ],
              ),
              //discount description
              const TProductTitleText(
                title:
                    'Freshen up your day with our affagato with fine quality beans',
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        //attributes
        Column(
          children: [
            const TSectionHeading(
              title: 'Additives',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(spacing: 8, children: [
              TChoiceChip(
                  text: 'Choco', selected: true, onSelected: (value) {}),
              TChoiceChip(
                  text: 'Butter', selected: false, onSelected: (value) {}),
              TChoiceChip(
                  text: 'Chips', selected: false, onSelected: (value) {}),
            ])
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Sizes',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                    text: 'Small', selected: true, onSelected: (value) {}),
                TChoiceChip(
                    text: 'Medium', selected: false, onSelected: (value) {}),
                TChoiceChip(
                    text: 'Large', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        )
      ],
    );
  }
}
