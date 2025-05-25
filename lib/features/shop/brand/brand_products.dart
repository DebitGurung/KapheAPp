import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/common/widgets/products/product_sortable/sortable_products.dart';
import 'package:kapheapp/features/shop/models/brand_model.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/effect/vertical_product_shimmer.dart';
import 'package:kapheapp/utils/helpers/cloud_helper_functions.dart';

import 'brand_card.dart';
import '../controllers/brand/brand_controller.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
        appBar: TAppBar(title: Text(brand.name)),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //brand detail
                  TBrandCard(
                    showBorder: true,
                    brand: brand,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  FutureBuilder(
                      future: controller.getBrandProduct(brandId: brand.id),
                      builder: (context, snapshot) {
                        //handler loader, no record, or error message
                        const loader = TVerticalProductShimmer();
                        final widget =
                            TCloudHelperFunctions.checkMultipleRecordState(
                                snapshot: snapshot, loader: loader);
                        if (widget != null) return widget;

                        //record found
                        final brandProducts = snapshot.data!;

                        return  TSortableProduct(products: brandProducts);
                      }),
                ],
              )),
        ));
  }
}
