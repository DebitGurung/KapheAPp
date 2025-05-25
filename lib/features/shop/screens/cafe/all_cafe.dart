import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/layouts/grid_layout.dart';

import '../../../../common/location/cafe_card.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/text/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/cafe_location/cafe_category_controller.dart';

class AllCafeScreen extends StatelessWidget {
  const AllCafeScreen({super.key,
  //   required this.cafeCategory,
  //   required this.cafeModel
  });
  //
  // final CafeCategoryModel cafeCategory;
  // final CafeModel cafeModel;

  @override
  Widget build(BuildContext context) {
    final controller = CafeCategoryController.instance;
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
              const SizedBox(height: TSizes.spaceBtwItems),
              // Cafes
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.featuredCafeCategories.isEmpty) {
                  return const Center(child: Text('No popular cafes found.'));
                }
                return TGridLayout(
                  itemCount: controller.featuredCafeCategories.length,
                  mainAxisExtent: 80,
                  itemBuilder: (context, index) {
                    final cafe = controller.featuredCafeCategories[index];
                    return TCafeCard(
                      showBorder: true,
                      cafe: cafe,
                      // onTap: () => Get.to(() => CafeBranch(cafe: cafe, cafeModel: cafeModel,)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}