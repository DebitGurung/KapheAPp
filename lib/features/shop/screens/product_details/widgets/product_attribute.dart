import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/controllers/product/variation_controller.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

class TProductAttribute extends StatelessWidget {
  const TProductAttribute({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = VariationController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: product.attributes.map((attribute) {
        return Padding(
          padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                attribute.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Obx(() {
                final availableValues = controller.getAttributesAvailabilityInVariation(product.variations, attribute.name);
                return Wrap(
                  spacing: TSizes.sm,
                  runSpacing: TSizes.sm,
                  children: (attribute.values ?? []).map((value) {
                    final isSelected = controller.selectedAttributes[attribute.name]?.toString() == value;
                    final isAvailable = availableValues.contains(value);
                    return ChoiceChip(
                      label: Text(value.toString()),
                      selected: isSelected,
                      onSelected: isAvailable
                          ? (selected) {
                        if (selected) {
                          controller.onAttributeSelected(product, attribute.name, value);
                        }
                      }
                          : null,
                      selectedColor: Theme.of(context).primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : (isAvailable ? Colors.black : Colors.grey),
                      ),
                      backgroundColor: isAvailable ? Colors.grey[200] : Colors.grey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(TSizes.sm),
                        side: BorderSide(
                          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }
}