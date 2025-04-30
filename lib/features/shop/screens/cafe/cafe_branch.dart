import 'package:flutter/material.dart';
import 'package:kapheapp/common/location/cafe_card.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/cafes/sortable/sortable_cafe.dart';

class CafeBranch extends StatelessWidget {
  const CafeBranch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Camilia'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TCafeCard(showBorder: true),
              SizedBox(height: TSizes.spaceBtwSections),
              TSortableCafe(),
            ],
          ),
        ),
      ),
    );
  }
}
