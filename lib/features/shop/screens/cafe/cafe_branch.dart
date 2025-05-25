import 'package:flutter/material.dart';
import 'package:kapheapp/common/location/cafe_card.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/cafes/sortable/sortable_cafe.dart';
import '../../models/cafe_category_model.dart';
import '../../models/cafe_model.dart';

class CafeBranch extends StatelessWidget {
  const CafeBranch({
    super.key,
    required this.cafe,
    required this.cafeModel});

  final CafeCategoryModel cafe;
  final CafeModel cafeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(cafe.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TCafeCard(
                showBorder: true,
                cafe: cafe,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              TSortableCafe(cafe: cafe, cafeModel: cafeModel,),
            ],
          ),
        ),
      ),
    );
  }
}