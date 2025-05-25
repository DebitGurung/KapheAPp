import 'package:flutter/material.dart';
import 'package:kapheapp/features/shop/models/cart_item_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/t_rounded_image.dart';
import '../../text/product_title_text.dart';
import '../../text/t_brand_title_text_with_cup_icon.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TBrandTitleTextWithCupIcon(title: cartItem.brand?.name ?? ''),
            Flexible(
                child: TProductTitleText(title: cartItem.title, maxLines: 1)),
            Text.rich(
              TextSpan(
                children: (cartItem.selectedVariation ?? {})
                    .entries
                    .map(
                      (e) => TextSpan(
                    children: [
                      TextSpan(
                          text: e.key,
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: e.value,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                )
                    .toList(),
              ),
            )
          ],
        )
      ],
    );
  }
}