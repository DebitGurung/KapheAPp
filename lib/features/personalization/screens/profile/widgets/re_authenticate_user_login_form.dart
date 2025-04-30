import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/features/personalization/controllers/user_controller.dart';
import 'package:kapheapp/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Re-Authenticate User'),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Form(
                key: controller.reAuthFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.verifyEmail,
                      validator: TValidator.validateEmail,
                      decoration: const InputDecoration(
                          prefix: Icon(Icons.arrow_circle_right_outlined),
                          labelText: TText.email),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),

                    Obx(
                      () => TextFormField(
                        obscureText: controller.hidePassword.value,
                        controller: controller.verifyPassword,
                        validator: (value) =>
                            TValidator.validateEmptyText('Password', value),
                        decoration: InputDecoration(
                          prefix: const Icon(Icons.check),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon:
                                  const Icon(Icons.disabled_visible_outlined)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    //login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              controller.reAuthenticateEmailAndPasswordUser(),
                          child: const Text('Verify')),
                    )
                  ],
                ),
              ))),
    );
  }
}
