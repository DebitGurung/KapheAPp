import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const  TAppBar(
        title:  Text('Add new address'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    labelText: 'Name'),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
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
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_2_outlined),
                          labelText: 'Name'),
                    ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwInputFields,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_2_outlined),
                          labelText: 'Name'),
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
