import 'package:flutter/material.dart';

import '../../../../../common/widgets/locations/location_visit_list/visit_list_locations.dart';
import '../../../../../utils/constants/sizes.dart';

class TVisitListItems extends StatelessWidget {
  const TVisitListItems({
    super.key,
    required this.showAddRemoveButton,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
      itemBuilder: (_, index) => const Column(
        children: [
           TVisitLocation(),

             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
