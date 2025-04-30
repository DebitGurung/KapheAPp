import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kapheapp/utils/constants/image_strings.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Ensure FirebaseAuthException is imported

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/user/user_model.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../network_manager/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Controllers
  final email = TextEditingController();
  final userName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    email.dispose();
    userName.dispose();
    lastName.dispose();
    password.dispose();
    firstName.dispose();
    phoneNumber.dispose();
    super.onClose();
  }

  void signup() async {
    try {
      // Dismiss keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      // Start loading
      TFullScreenLoader.openLoadingDialog('Processing...', TImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoader.warningSnackBar(
          title: 'No Internet Connection',
          message: 'Please check your network settings',
        );
        return;
      }

      // Form validation
      if (signupFormKey.currentState == null || !signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoader.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'You must accept the privacy policy to continue',
        );
        return;
      }

      // User registration
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Check user existence
      if (userCredential.user == null) {
        TFullScreenLoader.stopLoading();
        TLoader.errorSnackBar(
          title: 'Registration Failed',
          message: 'User creation failed - please try again',
        );
        return;
      }

      // Create user model
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: " ", // Use a default image
      );

      // Save user data
      final userRepository = Get.find<UserRepository>();
      await userRepository.saveUserRecord(newUser);

      // Success handling
      TFullScreenLoader.stopLoading();
      TLoader.successSnackBar(
        title: 'Success',
        message: 'Account created! Verify your email',
      );

      // Navigate to verification screen
      Get.offAll(() =>  VerifyEmailScreen(email: email.text.trim()));
    } on FirebaseAuthException catch (e) { // Handle Firebase errors
      TFullScreenLoader.stopLoading();
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'Registration failed. Please try again.';
      }
      TLoader.errorSnackBar(title: 'Registration Error', message: errorMessage);
    } catch (e) { // Generic error handler
      TFullScreenLoader.stopLoading();
      TLoader.errorSnackBar(
        title: 'Registration Error',
        message: 'Something went wrong. Please try again.',
      );
    }
  }
}