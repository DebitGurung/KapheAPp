import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/features/personalization/controllers/user_controller.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/text_strings.dart';
import 'package:kapheapp/utils/effect/shimmer.dart';

import '../../../../../common/widgets/products/product_cart/cart_menu_icon.dart';

class THomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const THomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TText.homeAppBarTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.apply(color: TColors.orange),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              //display a shimmer loader while profile is being loaded
              return const TShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: TColors.orange),
              );
            }
          }),
        ],
      ),
      actions: [
        TCartCounterIcon(
          iconColor: TColors.white,
          counterBgColor: TColors.orange,
          counterTextColor: TColors.white,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Fixed
}
