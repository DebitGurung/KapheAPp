import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TOrderList extends StatelessWidget {
  const TOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder:
          (_, index) => TRoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: dark ? TColors.black : TColors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Row1
                Row(
                  children: [
                    const Icon(Icons.shopping_bag),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Processing',
                            style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: TColors.primaryColor,
                              fontWeightDelta: 1,
                            ),
                          ),
                          Text(
                            '09 Nov 2025',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: TSizes.iconSm,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                //Row2
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.attach_file),
                          const SizedBox(width: TSizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Processing',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  '09 Nov 2025',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //row3
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month),
                          const SizedBox(width: TSizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order date',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  '01 Nov 2025',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
