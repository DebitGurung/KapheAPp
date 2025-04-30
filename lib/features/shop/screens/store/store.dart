import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/location/cafe_card.dart';
import 'package:kapheapp/common/location/location_menu_icon.dart';
import 'package:kapheapp/features/shop/controllers/category_controller.dart';
import 'package:kapheapp/features/shop/screens/store/widgets/category_tab.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/container/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/text/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../visitList/visti_list.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Cafe',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TLocationCounterIcon(
              onPress: () => Get.to(() => const VisitScreen()),
            ),
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: TSizes.spaceBtwItems),
                        const TSearchContainer(
                          text: 'Search for cafe',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        TSectionHeading(
                            title: 'Popular cafe', onPressed: () {}),
                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                        TGridLayout(
                          itemCount: 4,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            return const TCafeCard(showBorder: false);
                          },
                        ),
                      ],
                    ),
                  ),
                  bottom: TabBar(
                      tabs: categories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList()),
                ),
              ];
            },
            body: TabBarView(
                children: categories
                    .map((category) => TCategoryTab(
                          category: category,
                        ))
                    .toList())),
      ),
    );
  }
}
