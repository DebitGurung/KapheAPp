import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/layouts/grid_layout.dart';
import 'package:kapheapp/features/shop/screens/cafe/cafe_branch.dart';

import '../../../../common/location/cafe_card.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/text/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class AllCafeScreen extends StatelessWidget {
  const AllCafeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('All Cafe'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TSectionHeading(title: 'Popular Cafe'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              //cafes
              TGridLayout(
                  itemCount: 5,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) => TCafeCard(
                        showBorder: true,
                        onTap: () => Get.to(
                          () => TCafeCard(
                            showBorder: true,
                            onTap: () => Get.to(() => const CafeBranch()),
                          ),
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
