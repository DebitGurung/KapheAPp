import 'package:flutter/material.dart';
import '../../../../features/shop/models/cafe_category_model.dart';
import '../../../../features/shop/models/cafe_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../../locations/location_cards/location_card_vertical.dart';

class TSortableCafe extends StatelessWidget {
  const TSortableCafe({
    super.key, required this.cafeModel, required this.cafe
  });
  final CafeModel cafeModel;
  final CafeCategoryModel cafe;


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        //dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.sort)),
          onChanged: (value) {},
          items: ['Newest', 'Popular', 'Comfortable']
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        //products
        TGridLayout(
          itemCount: 11,
          itemBuilder: (_, index) => TLocationCardVertical( cafeModel: cafeModel, cafe: cafe,),
        )
      ],
    );
  }
}
