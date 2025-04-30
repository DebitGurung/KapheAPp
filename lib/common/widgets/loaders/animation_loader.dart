import 'package:flutter/material.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  }) : assert(!showAction || actionText != null,
  'ActionText is required when showAction is true');

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: THelperFunctions.isDarkMode(context)
          ? TColors.dark
          : TColors.white,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 200, // Constrained height
                    child: Lottie.asset(animation),
                  ),
                  const SizedBox(height: TSizes.defaultSpace),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: TSizes.defaultSpace),
                  if (showAction)
                    SizedBox(
                      width: 250,
                      child: OutlinedButton(
                        onPressed: onActionPressed,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: TColors.dark,
                        ),
                        child: Text(
                          actionText!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: TColors.light),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}