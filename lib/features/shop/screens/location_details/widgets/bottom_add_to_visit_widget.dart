import 'package:flutter/material.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TBottomAddToVisit extends StatelessWidget {
  const TBottomAddToVisit({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.primaryColor : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusLg),
            topRight: Radius.circular(TSizes.cardRadiusLg),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: TColors.orange,
                  side: const BorderSide(color: TColors.orange)),
              child: const Text('Add to visit')),
        ],
      ),
    );
  }
}
