import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:kapheapp/utils/effect/shimmer.dart';

import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';
import 'widgets/change_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : TImages.profile;
                      return controller.imageUploading.value
                          ? const TShimmerEffect(width: 80, height: 80)
                          : TCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Profile information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                onPressed: () => Get.to(() => const ChangeName()),
                title: 'Name',
                value: controller.user.value.fullName,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'User Name',
                value: controller.user.value.userName,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                onPressed: () {},
                title: 'User ID',
                value: controller.user.value.id,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'E-mail',
                value: controller.user.value.email,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'Gender',
                value: 'Male ',
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Close account',
                      style: TextStyle(color: Colors.red)),
                ),
              )
            ],
          )),
    );
  }
}
