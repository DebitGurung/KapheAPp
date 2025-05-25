import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/images/t_circular_image.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.orange,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
    this.width = 60,
    this.imagePadding = TSizes.sm,
    this.margin = const EdgeInsets.only(right: TSizes.spaceBtwItems),
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;
  final double width;
  final double imagePadding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      margin: margin,
      child: InkWell(
        borderRadius: BorderRadius.circular(TSizes.borderRadius),
        onTap: onTap,
        splashColor: TColors.primaryBackground,
        highlightColor: dark ? TColors.darkGrey : TColors.lightGrey,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TCircularImage(
                image: image,
                width: 48, // Fits within 72px height constraint
                height: 48,
                fit: BoxFit.cover,
                padding: imagePadding,
                isNetworkImage: isNetworkImage && image.isNotEmpty,
                backgroundColor: backgroundColor,
                overlayColor: dark ? TColors.light : TColors.dark,
                placeholder: const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Flexible(
                child: SizedBox(
                  width: width,
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: textColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}