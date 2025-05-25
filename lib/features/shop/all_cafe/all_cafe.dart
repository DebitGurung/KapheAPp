import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/features/shop/models/cafe_model.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../common/widgets/cafes/sortable/sortable_cafe.dart';
import '../models/cafe_category_model.dart';

class AllCafe extends StatelessWidget {
  const AllCafe({super.key, required this.cafe, required this.cafeModel});
  final CafeCategoryModel cafe;
  final CafeModel cafeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Popular cafe'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TSortableCafe(cafe: cafe, cafeModel: cafeModel,),
        ),
      ),
    );
  }
}
