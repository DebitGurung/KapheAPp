import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/features/shop/screens/cart/widgets/cart_items.dart';

import '../../../../utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: TCartItems(
            showAddRemoveButton: true,
          )),
    );
  }
}
