import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:kapheapp/common/widgets/custom_shapes/container/search_container.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/effect/vertical_product_shimmer.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../all_products/all_products.dart';
import '../../../controllers/product/product_controller.dart';
import '../../widgets/promo_slider.dart';
import 'home_appbar.dart';
import 'home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
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
                          textColor: TColors.orange,
                          onPressed: () {},
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(),
                  TSectionHeading(
                    title: 'Popular beverage',
                    showActionButton: true,
                    textColor: TColors.orange,
                    onPressed: () => Get.to(() => AllProducts(
                      title: 'Popular Beverages',
                      futureMethod: controller.getAllFeaturedProducts(),
                    )),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No featured products found. Check Firestore data and permissions.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    if (kDebugMode) print('Rendering ${controller.featuredProducts.length} products in UI');
                    return TGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) {
                        final product = controller.featuredProducts[index];
                        if (kDebugMode) print('Rendering product: ${product.id}, Title: ${product.title}, Price: ${product.price}, Thumbnail: ${product.thumbnail}');
                        return TProductCardVertical(product: product);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}