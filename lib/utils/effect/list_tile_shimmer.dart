import 'package:flutter/cupertino.dart';
import 'package:kapheapp/utils/effect/shimmer.dart';

import '../constants/sizes.dart';

class TListTileShimmer extends StatelessWidget {
  const TListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            TShimmerEffect(width: 100, height: 15),
            SizedBox(height: TSizes.spaceBtwItems),
            TShimmerEffect(width: 80, height: 12),
          ],
        )
      ],
    );
  }
}
