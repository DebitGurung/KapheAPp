import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/controllers/banner/banner_controller.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:kapheapp/common/widgets/images/t_rounded_image.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../../utils/effect/horizontal_product_shimmer.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
          () {
        if (controller.isLoading.value) {
          return const THorizontalProductShimmer();
        }

        if (controller.banners.isEmpty) {
          return const Center(child: Text('No data found!'));
        }

        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) => controller.updatePageIndicator(index),
              ),
              items: controller.banners.map((banner) {
                return banner.imageUrl.isNotEmpty
                    ? TRoundedImage(
                  imageUrl: banner.imageUrl,
                  isNetworkImage: true,
                  onPressed: () => Get.toNamed(banner.targetScreen),
                )
                    : const Icon(Icons.image_not_supported,
                    color: TColors.grey, size: 50);
              }).toList(),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Center(
              child: Obx(
                    () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      TCircularContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.only(right: 10),
                        backgroundColor:
                        controller.carousalCurrentIndex.value == i
                            ? TColors.primaryColor
                            : TColors.orange,
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}