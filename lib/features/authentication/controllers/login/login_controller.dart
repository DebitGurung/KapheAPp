import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kapheapp/data/repositories/authentication/authentication_repository.dart';
import 'package:kapheapp/features/personalization/controllers/user_controller.dart';
import 'package:kapheapp/utils/popups/full_screen_loader.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

import '../../../../network_manager/network_manager.dart';
import '../../../../utils/constants/image_strings.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs; //obs is an observer
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    // Handle potential null values from storage
    email.text = localStorage.read('Remember_Me_email') ?? '';
    password.text = localStorage.read('Remember_Me_password') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      // Clear previous errors
      loginFormKey.currentState?.reset();

      TFullScreenLoader.openLoadingDialog(
          'Logging you in', TImages.docerAnimation);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoader.warningSnackBar(
            title: 'No Internet', message: 'Please check your connection');
        return;
      }

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save ONLY EMAIL if remember me is selected (never store passwords)
      if (rememberMe.value) {
        localStorage.write('Remember_Me_email', email.text.trim());
        localStorage.write(
            'Remember_Me_password', password.text.trim()); // Clear any existing
      }

      // Login user
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

// Check if login actually succeeded
      if (userCredentials.user == null) {
        TFullScreenLoader.stopLoading();
        TLoader.errorSnackBar(title: 'Error', message: 'Invalid credentials');
        return;
      }

      // Additional security check
      if (!userCredentials.user!.emailVerified) {
        await AuthenticationRepository.instance.sendEmailVerification();
        TFullScreenLoader.stopLoading();
        TLoader.warningSnackBar(
            title: 'Verify Email',
            message: 'A verification link has been sent to your email');
        return;
      }

      // Save user record
      await userController.saveUserRecord(userCredentials);

      // Finalize
      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
          title: 'Login Failed',
          message: _getUserFriendlyError(e.toString()) // Sanitized message
          );
    }
  }

  String _getUserFriendlyError(String error) {
    if (error.contains('wrong-password')) return 'Invalid password';
    if (error.contains('user-not-found')) return 'Account not found';
    if (error.contains('too-many-requests')) {
      return 'Too many attempts. Try again later';
    }
    return 'Login failed. Please try again';
  }

  Future<void> googleSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog('Logging in', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
//google authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      //save user record
      await userController.saveUserRecord(userCredentials);

      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      //remove loader
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
