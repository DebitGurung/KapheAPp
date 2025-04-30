import 'package:flutter/cupertino.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/effect/shimmer.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            separatorBuilder: (_, __) =>
                const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (_, __) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  TShimmerEffect(width: 55, height: 55, radius: 55),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),

                  //text
                  TShimmerEffect(width: 100, height: 8),
                ],
              );
            }));
  }
}
