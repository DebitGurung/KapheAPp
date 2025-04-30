import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/features/shop/screens/visitList/widgets/visit_list_items.dart';

import '../../../../utils/constants/sizes.dart';

class VisitScreen extends StatelessWidget {
  const VisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Cafe visit',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: TVisitListItems(
            showAddRemoveButton: true,
          )),
    );
  }
}
