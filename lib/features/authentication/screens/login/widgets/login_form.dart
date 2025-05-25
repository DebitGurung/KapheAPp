// File: t_login_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/utils/validators/validation.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/login/login_controller.dart';
import '../../forget_password/forgot_password.dart';
import '../../signup/signup.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>(); // Use existing controller
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail),
                labelText: TText.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Password
            Obx(
                  () => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: TText.password,
                  prefixIcon: const Icon(Icons.border_color_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.toggle(),
                    icon: Icon(controller.hidePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            // Remember Me and Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                          () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) =>
                        controller.rememberMe.value = value ?? false,
                      ),
                    ),
                    const Text(TText.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(TText.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(TText.signIn),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(TText.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}