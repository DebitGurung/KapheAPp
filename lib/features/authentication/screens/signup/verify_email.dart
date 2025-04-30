import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/authentication/authentication_repository.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/signup/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put( VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(Icons.close))
        ],
      ),
      body: SingleChildScrollView(
        //padding for default equal space
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Lottie.asset(
                    TImages.deliveredEmailIllustration,
                    width: THelperFunctions.screenWidth() * 0.8,
                    height: 250,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Text(TText.confirmEmail,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(email ?? '',
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Text(TText.confirmEmailSubTitle,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: TSizes.spaceBtwSections),
               //success screen
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.checkEmailVerificationStatus(),
                        child: const Text(TText.tContinue)),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () => controller.sendEmailVerification() , child: const Text(TText.resendEmail)),
                  ),
                ],
              ))),
    );
  }
}
