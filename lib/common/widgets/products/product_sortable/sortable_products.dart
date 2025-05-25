import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/features/shop/controllers/all_product/all_product_controller.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProduct extends StatelessWidget {
  const TSortableProduct({
    super.key, required this.products,
  });

  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProduct(products);
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Popular beverages'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //dropdown
              DropdownButtonFormField(
                decoration:  const InputDecoration(prefixIcon: Icon(Icons.sort)),
                value: controller.selectedSortOption.value,
                onChanged: (value) {
                  controller.sortProducts(value!);
                },
                items: [
                  'Popular',
                  'Newest',
                  'Refreshing drinks',
                  'Relaxing drink',
                  'Dripped coffee'
                ]
                    .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                    .toList(),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              //products
              Obx(
                () => TGridLayout(
                  itemCount: controller.products.length,
                  itemBuilder: (_, index) =>  TProductCardVertical(product: controller.products[index],),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
