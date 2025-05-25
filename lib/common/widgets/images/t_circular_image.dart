import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/effect/shimmer.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.placeholder, // Added placeholder parameter
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final Widget? placeholder; // Define placeholder

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.black
                : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage && image.isNotEmpty
              ? CachedNetworkImage(
            fit: fit,
            color: overlayColor,
            imageUrl: image,
            progressIndicatorBuilder: (context, url, progress) =>
            const TShimmerEffect(width: 55, height: 55),
            errorWidget: (context, url, error) =>
            placeholder ?? const Icon(Icons.error, color: TColors.error),
          )
              : placeholder ??
              Image.asset(
                image.isNotEmpty
                    ? image
                    : 'assets/images/placeholder.png',
                fit: fit,
                color: overlayColor,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported,
                  color: TColors.grey,
                ),
              ),
        ),
      ),
    );
  }
}