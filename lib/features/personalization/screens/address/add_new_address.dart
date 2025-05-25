import 'package:flutter/material.dart';
import 'package:kapheapp/features/personalization/controllers/address_controller.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar:const  TAppBar(
        title:  Text('Add new address'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
              child: Column(
            children: [
              TextFormField(
                controller: controller.name,
                validator: (value) => TValidator.validateEmptyText('name', value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    labelText: 'Name'),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                controller: controller.name,
                validator: (value) => TValidator.validatePhoneNumber(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mobile_friendly),
                    labelText: 'Phone number'),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.city,
                      validator: (value) => TValidator.validateEmptyText('city', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_2_outlined),
                          labelText: 'City'),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwInputFields,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.state,
                      validator: (value) => TValidator.validateEmptyText('country', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_2_outlined),
                          labelText: 'Country'),
                    ),
                  ),
                ],
              ),  const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.street,
                      validator: (value) => TValidator.validateEmptyText('street', value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.streetview_outlined),
                          labelText: 'Street'),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwInputFields,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.postalCode,
                      validator: (value) => TValidator.validateEmptyText('postalCode', value),
                      decoration: const InputDecoration(
                          prefixIcon:  Icon(Icons.signpost),
                          labelText: 'Postal code'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.name,
                      validator: (value) => TValidator.validateEmptyText('city', value),
                      decoration: const InputDecoration(
                          prefixIcon:  Icon(Icons.maps_home_work_outlined),
                          labelText: 'City'),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwInputFields,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.name,
                      validator: (value) => TValidator.validateEmptyText('state', value),
                      decoration: const InputDecoration(
                          prefixIcon:  Icon(Icons.local_activity_rounded),
                          labelText: 'State'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: TSizes.defaultSpace,
              ),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Save')))
            ],
          )),
        ),
      ),
    );
  }
}
