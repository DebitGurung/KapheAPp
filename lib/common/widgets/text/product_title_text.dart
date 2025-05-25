import 'package:flutter/material.dart';

class TProductTitleText extends StatelessWidget {
  const TProductTitleText({
    super.key,
    this.title = '',
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.ellipsis, // Added overflow parameter
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow; // Define overflow as a parameter

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.titleSmall,
      overflow: overflow, // Use the overflow parameter
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}