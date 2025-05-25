import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/favourite_icon/favourite_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../icons/t_circular_icon.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => TCircularIcon(
        icon: controller.isFavourite(productId)
            ? Icons.favorite_border
            : Icons.favorite_border_outlined,
        color: controller.isFavourite(productId) ? TColors.error : null,
        onPressed: () => controller.toggleFavouriteProduct(productId),
      ),
    );
  }
}
