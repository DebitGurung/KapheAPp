import 'package:flutter/material.dart';
import 'package:kapheapp/common/styles/spacing_styles.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: TSpacingStyle.paddingWithAppBarHeight * 2,
              child: Column(children: [
               //image
                Lottie.asset(image,width: MediaQuery.of(context).size.width *0.6),
                const SizedBox(height: TSizes.spaceBtwSections),
                //Title and subtitle
                Text(title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(subTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: TSizes.spaceBtwSections),
               //buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: onPressed, child: const Text(TText.tContinue)),
                ),
              ]))),
    );
  }
}
