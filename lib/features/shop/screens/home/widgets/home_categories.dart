import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:kapheapp/utils/effect/category_shimmer.dart';
import 'package:kapheapp/features/shop/controllers/product/category_controller.dart';
import 'package:kapheapp/features/shop/screens/sub_category/sub_categories.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No data found!',
            style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 100,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return TVerticalImageText(
              image: category.image.isNotEmpty ? category.image : 'https://via.placeholder.com/100', // Fallback image for error
              title: category.name,
              isNetworkImage: category.image.isNotEmpty,
              onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
            );
          },
        ),
      );
    });
  }
}