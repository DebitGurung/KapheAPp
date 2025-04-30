import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../common/widgets/layouts/grid_layout.dart';
import '../../../common/widgets/products/product_cards/product_card_vertical.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
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
                decoration: const InputDecoration(prefixIcon: Icon(Icons.sort)),
                onChanged: (value) {},
                items: [
                  'Strawberry Frappuccino',
                  'Double shot Americano',
                  'Single shot doppio',
                  'Light foamed latte',
                  'Dripped coffee'
                ]
                    .map((option) =>
                        DropdownMenuItem(value: option, child: Text(option)))
                    .toList(),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              //products
              TGridLayout(
                itemCount: 11,
                itemBuilder: (_, index) => const TProductCardVertical(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
