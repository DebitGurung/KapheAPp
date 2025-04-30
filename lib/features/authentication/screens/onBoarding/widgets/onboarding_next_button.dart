import 'package:flutter/material.dart';
import 'package:kapheapp/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/device/device_utility.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? TColors.primaryColor : Colors.orange,
        ),
        child: const Icon(Icons.arrow_forward_outlined),
      ),
    );
  }
}
