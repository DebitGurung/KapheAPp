import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/features/personalization/controllers/address_controller.dart';
import 'package:kapheapp/features/personalization/screens/address/widgets/single_address.dart';
import 'package:kapheapp/utils/helpers/cloud_helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Icons.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              //use key to trigger refresh
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {

                final response = TCloudHelperFunctions.checkMultipleRecordState(snapshot: snapshot);
                if(response != null) return response;


                final addresses = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                    itemCount: addresses.length,
                    itemBuilder: (_,index) => TSingleAddress(address: addresses[index],
                        onTap: () => controller.selectedAddress(addresses[index]),
                ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
