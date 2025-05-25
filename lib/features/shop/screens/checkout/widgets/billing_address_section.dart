import 'package:flutter/material.dart';
import 'package:kapheapp/features/personalization/controllers/address_controller.dart';

import '../../../../../common/widgets/text/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Payment method',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context)),
       addressController.selectedAddress.value.id.isNotEmpty
           ? Column(
          children: [
            Text(
              'Chill guy', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: TSizes.spaceBtwItems / 2,),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 16,),
                const SizedBox(width: TSizes.spaceBtwItems / 2,),
                Text('9876543210', style: Theme.of(context).textTheme.bodyMedium,)
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Row(
              children: [
                const Icon(Icons.location_city, color: Colors.grey, size: 16,),
                const SizedBox(width: TSizes.spaceBtwItems / 2,),
                Expanded(
                  child: Text('New york, Harlem, St no 2910, USA',
                    style: Theme.of(context).textTheme.bodyMedium,
                    softWrap: true))
              ],
            ),
          ],
        ) : Text('Select Address', style: Theme.of(context).textTheme.bodyMedium ),

      ],
    );
  }
}
