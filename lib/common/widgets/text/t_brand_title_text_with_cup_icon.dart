import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/text/t_brand_title_text.dart';
import 'package:kapheapp/utils/constants/enums.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';

class TBrandTitleTextWithCupIcon extends StatelessWidget {
  const TBrandTitleTextWithCupIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = TColors.primaryColor,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: TSizes.xs),
        Icon(
          Icons.coffee,
          color: iconColor,
          size: TSizes.iconXs,
        ),
      ],
    );
  }
}
