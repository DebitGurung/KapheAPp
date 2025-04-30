import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = TSizes.cardRadiusLg,
      this.padding,
      this.margin,
      this.backgroundColor = TColors.white,
      this.child,
      this.showBorder = false,
      this.borderColor = TColors.borderPrimary});

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border:
            showBorder ? Border.all(color: borderColor) : null, // Added comma
      ),
      child: child,
    );
  }
}
