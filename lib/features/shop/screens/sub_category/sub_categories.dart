import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/images/t_rounded_image.dart';
import 'package:kapheapp/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/utils/constants/image_strings.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Coffee'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TRoundedImage(
                width: double.infinity,
                imageUrl: TImages.promoBanner3,
                applyImageRadius: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Column(
                children: [
                  //heading
                  TSectionHeading(title: 'Coffee types', onPressed: () {}),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder:
                          (context, index) =>
                              const SizedBox(width: TSizes.spaceBtwItems),
                      itemBuilder:
                          (context, index) => const TProductCardHorizontal(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
