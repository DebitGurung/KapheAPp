import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/features/personalization/controllers/update_name_controller.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/constants/text_strings.dart';
import 'package:kapheapp/utils/validators/validation.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change Name',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(
              'Use your name for better verification.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText('First name', value),
                    decoration: const InputDecoration(
                      labelText: TText.firstName,
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last name', value),
                    decoration: const InputDecoration(
                      labelText: TText
                          .lastName, // Fixed from TText.firstName to TText.lastName
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserName(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
