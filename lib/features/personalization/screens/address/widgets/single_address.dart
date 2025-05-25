// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kapheapp/features/personalization/controllers/address_controller.dart';
import 'package:kapheapp/features/personalization/models/address_model.dart';


import '../../../../../common/widgets/custom_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.address,
    required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: TRoundedContainer(
          width: double.infinity,
          showBorder: true,
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: selectedAddress
              ? TColors.primaryColor.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
              ? TColors.darkerGrey
              : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                    selectedAddress
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: selectedAddress
                        ? dark
                        ? TColors.light
                        : TColors.dark.withOpacity(0.6)
                        : null),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                   Text(address.formattedPhoneNo,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                   Text(
                    address.toString(),
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    );
  }
}
