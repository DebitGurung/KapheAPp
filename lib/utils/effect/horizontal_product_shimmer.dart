
import 'package:flutter/cupertino.dart';
import 'package:kapheapp/utils/effect/shimmer.dart';

import '../constants/sizes.dart';

class THorizontalProductShimmer extends StatelessWidget {
  const THorizontalProductShimmer({
    super.key,
    this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return  Container(
    margin:  EdgeInsets.only(bottom: TSizes.spaceBtwItems),
    height: 120,
    child: ListView.separated(
    itemCount: itemCount,

    shrinkWrap: true,
    scrollDirection:  Axis.horizontal,

    separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems),
    itemBuilder: (_,__) =>
    const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    TShimmerEffect(width: 120, height: 120),
    SizedBox(height: TSizes.spaceBtwItems),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: TSizes.spaceBtwItems / 2),

        ],
      )
    ]
    )
    )
    );

  }
}
