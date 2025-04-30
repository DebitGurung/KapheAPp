import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/personalization/controllers/user_controller.dart';
import 'package:kapheapp/utils/constants/image_strings.dart';
import 'package:kapheapp/utils/popups/full_screen_loader.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../network_manager/network_manager.dart';
import '../screens/profile/profile.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeName();
    super.onInit();
  }

  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Updating your information', TImages.docerAnimation);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //update user's first and last name in the firebase fire store
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      //update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success message
      TLoader.successSnackBar(title: 'User name has been updated.');

      //move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
          title: 'Sorry there was a problem!', message: e.toString());
    }
  }
}
