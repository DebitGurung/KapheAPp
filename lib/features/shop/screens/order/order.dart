import 'package:flutter/material.dart';
import 'package:kapheapp/features/shop/screens/order/widgets/order_list.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Order', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace), child: TOrderList()),
    );
  }
}
