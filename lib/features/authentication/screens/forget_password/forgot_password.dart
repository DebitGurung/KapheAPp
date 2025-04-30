import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/utils/validators/validation.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/forget_password/forget_password_controller.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(TText.forgetPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TText.forgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections * 2),
            //text field
              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  validator: TValidator.validateEmail,
                  decoration: const InputDecoration(
                    labelText: TText.email,
                    prefixIcon: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.sendPasswordResetEmail(),
                      child: const Text(TText.submit))),
            ])));
  }
}
