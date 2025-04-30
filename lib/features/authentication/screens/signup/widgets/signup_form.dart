import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // First and Last Name Row
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      TValidator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TText.firstName,
                      prefixIcon: Icon(Icons.account_box_outlined)),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TText.lastName,
                      prefixIcon: Icon(Icons.account_box_outlined)),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                TValidator.validateEmptyText('User name', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TText.userName, prefixIcon: Icon(Icons.person_add)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TText.email, prefixIcon: Icon(Icons.mail_outline)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TText.phoneNo, prefixIcon: Icon(Icons.call)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hidePassword.value, //observer
              expands: false,
              decoration: InputDecoration(
                  labelText: TText.password,
                  prefixIcon: const Icon(Icons.border_color_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                  )),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Terms & Conditions
          const TTermsAndConditionCheckbox(),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(TText.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
