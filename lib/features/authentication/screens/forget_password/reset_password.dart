import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:kapheapp/utils/constants/image_strings.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../login/login.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Changed from start
            children: [
              Lottie.asset(
                TImages.deliveredEmailIllustration,
                width: THelperFunctions.screenWidth() * 0.8,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              // Email text with full width
              SizedBox(
                width: double.infinity,
                child: Text(
                  email,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Title with full width
              SizedBox(
                width: double.infinity,
                child: Text(
                  TText.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Subtitle with full width
              SizedBox(
                width: double.infinity,
                child: Text(
                  TText.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text(TText.done),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => ForgetPasswordController.instance
                      .resendPasswordResetEmail(email),
                  child: const Text(TText.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}