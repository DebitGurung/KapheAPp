import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/controllers/product/variation_controller.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = VariationController.instance;
    final isVariable = product.beverageType == 'variable';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Title
        Text(
          product.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Price
        Obx(() {
          final price = isVariable
              ? controller.getVariationPrice(product)
              : product.price.toString();
          return Text(
            'Rs $price',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.orange,
            ),
          );
        }),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Stock Status
        Obx(() {
          final stockStatus = isVariable
              ? controller.displayedStockStatus.value
              : product.availabilityStatus;
          return Row(
            children: [
              Text(
                'Status: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                stockStatus,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: stockStatus.toLowerCase() == 'in stock' ? Colors.green : Colors.red,
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: TSizes.spaceBtwItems),
      ],
    );
  }
}