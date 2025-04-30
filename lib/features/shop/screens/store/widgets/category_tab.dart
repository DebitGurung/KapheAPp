import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/layouts/grid_layout.dart';
import 'package:kapheapp/common/widgets/locations/location_cards/location_card_vertical.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/features/shop/models/category_model.dart';

import '../../../../../common/location/cafe_show_case.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TBrandShowcase(
                images: [TImages.cafe1, TImages.cafe2, TImages.cafe1],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSectionHeading(title: 'Also visit', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),
              TGridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => const TLocationCardVertical(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
