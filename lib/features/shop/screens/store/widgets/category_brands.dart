import 'package:flutter/cupertino.dart';

import '../../../../../common/location/brand_show_case.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/effect/box_shimmer.dart';
import '../../../../../utils/effect/list_tile_shimmer.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../controllers/brand/brand_controller.dart';
import '../../../models/category_model.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          const loader = Column(
            children: [
              TListTileShimmer(),
              SizedBox(height: TSizes.spaceBtwItems),
              TBoxesShimmer(),
              SizedBox(height: TSizes.spaceBtwItems),
            ],
          );

          final widget = TCloudHelperFunctions.checkMultipleRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;

          //record found
          final brands = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index) {
              final brand = brands[index];
              return FutureBuilder(
                  future:
                      controller.getBrandProduct(brandId: brand.id, limit: 3),
                  builder: (context, snapshot) {
                    //handle loader, no record, or error message
                    final widget =
                        TCloudHelperFunctions.checkMultipleRecordState(
                            snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    //record found
                    final products = snapshot.data!;

                    return TBrandShowcase(
                        brand: brand,
                        images: products.map((e) => e.thumbnail).toList());
                  });
            },
          );
        });
  }
}
