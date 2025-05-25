import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/brand/brand_card.dart';
import 'package:kapheapp/features/shop/brand/brand_products.dart';
import 'package:kapheapp/common/location/location_menu_icon.dart';
import 'package:kapheapp/common/widgets/appbar/tabbar.dart';
import 'package:kapheapp/features/shop/controllers/product/category_controller.dart';
import 'package:kapheapp/features/shop/screens/cafe/all_cafe.dart';
import 'package:kapheapp/features/shop/screens/store/widgets/category_tab.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';
import '../../../../utils/effect/brands_shimmer.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/container/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/text/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/brand/brand_controller.dart';
import '../visitList/visti_list.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Register CategoryController
    final controller = Get.put(CategoryController());
    final brandController = Get.put(BrandController());
    return Obx(() {
      final categories = controller.featuredCategories;
      return DefaultTabController(
        length: categories.isEmpty ? 1 : categories.length,
        child: Scaffold(
          appBar: TAppBar(
            title: Text('Cafe', style: Theme.of(context).textTheme.headlineMedium),
            actions: [
              TLocationCounterIcon(
                onPress: () => Get.to(() => const VisitScreen()),
              ),
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 440,
                  automaticallyImplyLeading: false,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const TSearchContainer(
                          text: 'Search for cafe',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        TSectionHeading(
                          title: 'Featured Cafe Brands',
                          onPressed: () => Get.to(() => const AllCafeScreen()),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                        Obx(() {
                          if (brandController.isLoading.value) {
                            return const TBrandsShimmer();
                          }
                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                              child: Text(
                                'No data found!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: Colors.white),
                              ),
                            );
                          }
                          return TGridLayout(
                            itemCount: brandController.featuredBrands.length,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final brand = brandController.featuredBrands[index];
                              return TBrandCard(
                                showBorder: true,
                                brand: brand,
                                onTap: () => Get.to(() => BrandProducts(brand: brand)),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  bottom: TTabBar(
                    tabs: categories
                        .map((category) => Tab(child: Text(category.name)))
                        .toList(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: categories.isEmpty
                  ? [const Center(child: CircularProgressIndicator())]
                  : categories.map((category) => TCategoryTab(category: category)).toList(),
            ),
          ),
        ),
      );
    });
  }
}