import 'package:flutter/material.dart';
import 'package:kapheapp/features/shop/controllers/product/cart_controller.dart';
import 'package:kapheapp/utils/helpers/price_calculator.dart';

import '../../../../../utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Rs $subTotal',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery charge',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Rs ${TPriceCalculator.calculateDeliveryCost(subTotal, 'Pokhara')}',
              style: Theme.of(context).textTheme.labelLarge,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax fee',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Rs ${TPriceCalculator.calculateTaxAmount(subTotal, 'Pokhara')}',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order total',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Rs ${TPriceCalculator.calculateTotalPrice(subTotal, 'Pokhara')}',
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ],
    );
  }
}
