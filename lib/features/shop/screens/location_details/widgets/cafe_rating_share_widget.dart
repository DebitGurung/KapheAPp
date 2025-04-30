import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class TCafeRatingAndShare extends StatelessWidget {
  const TCafeRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.yellow,
              size: 24,
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: '5.0', style: Theme.of(context).textTheme.bodyMedium),
              const TextSpan(text: '(12)'),
            ]))
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: TSizes.iconMd,
            )),
      ],
    );
  }
}
