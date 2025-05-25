import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/brand/brand_card.dart';
import 'package:kapheapp/features/shop/brand/brand_products.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/common/widgets/layouts/grid_layout.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../utils/effect/brands_shimmer.dart';
import '../controllers/brand/brand_controller.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key, });


  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;

    return Scaffold(
      appBar: const TAppBar(
        title: Text('Cafe brand'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TSectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
//brands
              Obx(
                      () {
                    if(brandController.isLoading.value) return const TBrandsShimmer();

                    if(brandController.featuredBrands.isEmpty) {
                      return Center (
                          child: Text('No data found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)
                          )
                      );

                    }

                    return TGridLayout(
                      itemCount: brandController.allBrands.length,
                      mainAxisExtent: 80,
                      itemBuilder: (_, index) {
                        final brand = brandController.allBrands[index];

                        return  TBrandCard(showBorder: true, brand: brand,
                        onTap: () => Get.to(() =>  BrandProducts(brand: brand,)));
                      },
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
