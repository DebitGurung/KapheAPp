import 'package:flutter/material.dart';

import '../../../../../common/widgets/product_price/product_price_text.dart';
import '../../../../../common/widgets/products/product_cart/add_remove_button.dart';
import '../../../../../common/widgets/products/product_cart/cart_item.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    required this.showAddRemoveButton,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
      itemBuilder: (_, index) => Column(
        children: [
          const TCartItem(),
          if (showAddRemoveButton)
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
          if (showAddRemoveButton)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    TProductQuantityWithAddRemoveButton(),
                  ],
                ),
                TProductPriceText(price: '190'),
              ],
            ),
        ],
      ),
    );
  }
}
