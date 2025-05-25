import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/cafe_location/location_image_controller.dart';
import '../../../models/cafe_model.dart';

class TLocationImageSlider extends StatelessWidget {
  const TLocationImageSlider({
    super.key,
    required this.dark,
    required this.cafe,
  });

  final bool dark;
  final CafeModel cafe;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(LocationImageController());
    final images = controller.getAllLocationImages(cafe);

    if (images.isEmpty) return const SizedBox();

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.primaryColor : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedLocationImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        errorWidget: (_, __, ___) => const Icon(Icons.error),
                        progressIndicatorBuilder: (_, __, progress) =>
                            CircularProgressIndicator(
                                value: progress.progress,
                                color: TColors.primaryColor),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (_, index) => Obx(() {
                    final isSelected = controller.selectedLocationImage.value == images[index];
                    return TRoundedImage(
                      width: 80,
                      imageUrl: images[index],
                      isNetworkImage: true,
                      onPressed: () => controller.selectedLocationImage.value = images[index],
                      border: Border.all(
                          color: isSelected ? TColors.primaryColor : Colors.transparent,
                          width: 2
                      ),
                    );
                  }),
                ),
              ),
            ),
            const TAppBar(
              showBackArrow: true,
              actions: [TCircularIcon(icon: Icons.favorite, color: Colors.red)],
            )
          ],
        ),
      ),
    );
  }
}