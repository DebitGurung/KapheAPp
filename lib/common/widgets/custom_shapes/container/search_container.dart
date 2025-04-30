import 'package:flutter/material.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/device/device_utility.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Icons.search,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
            color:
                showBackground
                    ? dark
                        ? TColors.dark
                        : TColors.white
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: TColors.orange) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: TColors.orange),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(
                // Fixed: Uses text parameter
                text,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
