// File: login_controller.dart
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
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('Remember_Me_email') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog('Logging you in', TImages.docerAnimation);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoader.warningSnackBar(
            title: 'No Internet', message: 'Please check your connection');
        return;
      }

      // Form validation
      if (loginFormKey.currentState == null || !loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save email if remember me is selected
      if (rememberMe.value) {
        localStorage.write('Remember_Me_email', email.text.trim());
      } else {
        localStorage.remove('Remember_Me_email');
      }

      // Login user
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Check if login succeeded
      if (userCredentials.user == null) {
        TFullScreenLoader.stopLoading();
        TLoader.errorSnackBar(title: 'Error', message: 'Invalid credentials');
        return;
      }

      // Check email verification
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
        message: _getUserFriendlyError(e.toString()),
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

      final userCredentials =
      await AuthenticationRepository.instance.signInWithGoogle();

      await userController.saveUserRecord(userCredentials);

      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
