import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/features/personalization/models/address_model.dart';
import 'package:kapheapp/network_manager/network_manager.dart';
import 'package:kapheapp/utils/constants/image_strings.dart';
import 'package:kapheapp/utils/helpers/cloud_helper_functions.dart';
import 'package:kapheapp/utils/popups/full_screen_loader.dart';
import '../../../common/widgets/loaders/circular_loader.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/loaders.dart';
import '../screens/address/add_new_address.dart';
import '../screens/address/widgets/single_address.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;

  // variable
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  // fetch all user-specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      // Fetch addresses
      final address = await addressRepository.fetchUserAddresses();
      selectedAddress.value = address.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return address;
    } catch (e) {
      TLoader.errorSnackBar(
        title: 'Address not found, something went wrong!',
        message: e.toString(),
      );
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const TCircularLoader(),
      );
      // Clear the selected address
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the "selected" field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      TLoader.errorSnackBar(
        title: 'Error in selection',
        message: e.toString(),
      );
    }
  }

  Future addNewAddresses() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Address..', TImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form validation
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save address data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      // Update selected address status
      address.id = id;
      await selectAddress(
          address); // Fixed: Changed from selectedAddress(address) to selectAddress(address)

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoader.successSnackBar(
          title: 'Congratulations',
          message: 'Your address has been saved successfully.');

      // Refresh addresses data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
        title: 'Address not found ',
        message: e.toString(),
      );
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Select address'),
            FutureBuilder(
                future: getAllUserAddresses(),
                builder: (_, snapshot) {
                  //helper function : handles loader, records, error
                  final response =
                      TCloudHelperFunctions.checkMultipleRecordState(
                          snapshot: snapshot);
                  if (response != null) return response;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => TSingleAddress(
                      address: snapshot.data![index],
                      onTap: () async {
                        await selectAddress(snapshot.data![index]);
                        Get.back();
                      },
                    ),
                  );
                }),
            const SizedBox(height: TSizes.defaultSpace * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const AddNewAddressScreen()),
                  child: const Text('Add new address')),
            )
          ],
        ),
      ),
    );
  }

  // Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
