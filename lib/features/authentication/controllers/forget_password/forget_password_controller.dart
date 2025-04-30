import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/authentication/authentication_repository.dart';
import 'package:kapheapp/utils/constants/image_strings.dart';
import 'package:kapheapp/utils/popups/full_screen_loader.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

import '../../../../network_manager/network_manager.dart';
import '../../screens/forget_password/reset_password.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

//send reset password email
  sendPasswordResetEmail() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog(
          'Your request is being processed', TImages.docerAnimation);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //send email to reset password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoader.successSnackBar(
          title: 'Email has been sent',
          message: 'Please check your email to reset password'.tr);

      //redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      //remove loader
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog(
          'Your request is being processed', TImages.docerAnimation);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //send email to reset password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email);

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoader.successSnackBar(
          title: 'Email has been sent',
          message: 'Please check your email to reset password'.tr);
    } catch (e) {
      //remove loader
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
    }
  }
}
