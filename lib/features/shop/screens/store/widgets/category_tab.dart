import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/layouts/grid_layout.dart';
import 'package:kapheapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/features/shop/controllers/product/category_controller.dart';
import 'package:kapheapp/features/shop/models/category_model.dart';
import 'package:kapheapp/features/shop/screens/store/widgets/category_brands.dart';
import 'package:kapheapp/utils/effect/vertical_product_shimmer.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../all_products/all_products.dart';


class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(category: category),
              const SizedBox(height: TSizes.spaceBtwItems),
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  final widget =
                  TCloudHelperFunctions.checkMultipleRecordState(
                      snapshot: snapshot, loader: const TVerticalProductShimmer());
                  if (widget != null) return widget;

                  //record found
                  final products = snapshot.data!;

                  return Column(
                    children: [
                      TSectionHeading(
                        title: 'Also visit',
                        onPressed: () => Get.to(AllProducts(
                          title: category.name,
                          futureMethod: controller.getCategoryProducts(categoryId: category.id,limit: -1),
                        )),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => TProductCardVertical(
                              product: products[index])),
                    ],
                  );
                }
              ),


            ],
          ),
        ),
      ],
    );
  }
}