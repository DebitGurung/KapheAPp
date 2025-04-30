import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:kapheapp/utils/constants/image_strings.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../login/login.dart';

class ResetPasswordScreen extends StatelessWidget {
  const  ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.clear)),
      ]),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image:
                          const AssetImage(TImages.deliveredEmailIllustration),
                      width: THelperFunctions.screenWidth() * 0.8,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    //email, title and subtitle
                    Text(
                      email,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text(TText.changeYourPasswordTitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text(TText.changeYourPasswordSubTitle,
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    //buttons
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              Get.offAll(() => const LoginScreen()),
                          child: const Text(TText.done)),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () => ForgetPasswordController.instance
                              .resendPasswordResetEmail(email),
                          child: const Text(TText.resendEmail)),
                    ),
                  ]))),
    );
  }
}
