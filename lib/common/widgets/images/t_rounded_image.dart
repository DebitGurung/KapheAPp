import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage && imageUrl.isNotEmpty
              ? CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit,
            width: width,
            height: height,
            progressIndicatorBuilder: (context, url, progress) =>
            const SizedBox(
                width: double.infinity,
                height: 190,
                child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red),
          )
              : Image.asset(
            imageUrl.isNotEmpty
                ? imageUrl
                : 'assets/images/placeholder.png',
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}