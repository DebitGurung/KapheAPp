import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:kapheapp/common/widgets/custom_shapes/container/search_container.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/features/shop/screens/widgets/promo_slider.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../all_products/all_products.dart';
import 'home_appbar.dart';
import 'home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const THomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSearchContainer(text: 'Search for beverages'),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: 'Beverage category',
                          showActionButton: false,
                          textColor: TColors.white,
                          onPressed: () {},
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(
                  ),
                  TSectionHeading(
                    title: 'Popular beverage',
                    showActionButton: false,
                    textColor: TColors.white,
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TGridLayout(
                      itemCount: 2,
                      itemBuilder: (_, index) => const TProductCardVertical()),
    ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
