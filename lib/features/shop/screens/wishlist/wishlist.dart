import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/common/widgets/icons/t_circular_icon.dart';
import 'package:kapheapp/common/widgets/layouts/grid_layout.dart';
import 'package:kapheapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:kapheapp/features/shop/screens/home/widgets/home.dart';

import '../../../../utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Icons.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(
                  itemCount: 2,
                  itemBuilder: (_, index) => const TProductCardVertical()),
            ],
          ),
        ),
      ),
    );
  }
}
