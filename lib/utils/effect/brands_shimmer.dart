import 'package:flutter/cupertino.dart';
import 'package:kapheapp/common/widgets/layouts/grid_layout.dart';
import 'package:kapheapp/utils/effect/shimmer.dart';

class TBrandsShimmer extends StatelessWidget {
  const TBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const TShimmerEffect(width: 300, height: 80)
    );
  }
}
