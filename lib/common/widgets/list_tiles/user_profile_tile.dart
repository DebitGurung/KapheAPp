import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/personalization/controllers/user_controller.dart';

import '../../../features/personalization/screens/profile/profile.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/t_circular_image.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(() {
      final user = controller.user.value;
      return ListTile(
        leading: const TCircularImage(
          image: TImages.profile,
          width: 50,
          height: 50,
          padding: 0,
        ),
        title: Text(
         controller.user.value.fullName, // Handle null case
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white),
        ),
        subtitle: Text(
          controller.user.value.email, // Handle null case
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.white),
        ),
        trailing: IconButton(
          onPressed: () => Get.to(() => const ProfileScreen()),
          icon: const Icon(Icons.edit, color: TColors.white),
        ),
      );
    });
  }
}
