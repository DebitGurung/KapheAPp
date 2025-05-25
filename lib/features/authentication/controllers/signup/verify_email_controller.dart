import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../navigation/navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../screens/login/login.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final deviceStorage = GetStorage();
  Timer? _verificationTimer;

  @override
  void onInit() {
    // Check if the user is already verified
    checkInitialVerificationStatus();
    super.onInit();
  }

  @override
  void onClose() {
    _verificationTimer?.cancel();
    super.onClose();
  }

  // Check initial verification status to avoid unnecessary verification flow
  void checkInitialVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      TLoader.errorSnackBar(
        title: 'Error',
        message: 'No user is currently signed in.',
      );
      Get.offAll(() => const LoginScreen());
      return;
    }

    await currentUser.reload();
    final updatedUser = FirebaseAuth.instance.currentUser;

    if (updatedUser != null && updatedUser.emailVerified) {
      // If already verified, skip verification flow and go to NavigationMenu
      Get.find<NavigationController>().selectedIndex.value = 0;
      Get.offAll(() => const NavigationMenu());
    } else {
      // If not verified, send email and start timer
      sendEmailVerification();
      setTimerForAutoRedirect();
    }
  }

  // Send email verification link
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoader.successSnackBar(
        title: 'Email Sent',
        message: 'Please check your email inbox and verify your email.',
      );
    } catch (e) {
      String errorMessage = _getFriendlyErrorMessage(e);
      TLoader.errorSnackBar(
        title: 'Error',
        message: errorMessage,
      );
    }
  }

  // Timer to auto redirect on email verification
  void setTimerForAutoRedirect() {
    // Store the timestamp of when the verification process started
    final verificationStartTime = DateTime.now().millisecondsSinceEpoch;
    deviceStorage.write('verificationStartTime', verificationStartTime);

    _verificationTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.reload();
        final updatedUser = FirebaseAuth.instance.currentUser;

        if (updatedUser != null && updatedUser.emailVerified) {
          timer.cancel();
          // Check if this is a new verification by comparing timestamps
          final lastVerificationTime = deviceStorage.read('lastVerificationTime') ?? 0;
          deviceStorage.write('lastVerificationTime', DateTime.now().millisecondsSinceEpoch);

          if (lastVerificationTime == 0 || verificationStartTime > lastVerificationTime) {
            // Show SuccessScreen only for new verifications
            Get.off(() => SuccessScreen(
              image: TImages.successfullyRegisterAnimation,
              title: TText.yourAccountCreatedTitle,
              subTitle: TText.yourAccountCreatedSubTitle,
              onPressed: () => AuthenticationRepository.instance.screenRedirect(),
            ));
          } else {
            // Skip SuccessScreen for already verified users
            Get.find<NavigationController>().selectedIndex.value = 0;
            Get.offAll(() => const NavigationMenu());
          }
        }
      } else {
        timer.cancel();
        TLoader.errorSnackBar(
          title: 'Error',
          message: 'No user is currently signed in.',
        );
        Get.offAll(() => const LoginScreen());
      }
    });
  }

  // Manually check if email is verified
  Future<void> checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await currentUser.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
        _verificationTimer?.cancel();
        Get.find<NavigationController>().selectedIndex.value = 0;
        Get.offAll(() => const NavigationMenu());
      }
    }
  }

  // Map errors to user-friendly messages
  String _getFriendlyErrorMessage(dynamic error) {
    if (error.toString().contains('App attestation failed')) {
      return 'Unable to verify app. Please try again later.';
    } else if (error.toString().contains('Too many attempts')) {
      return 'Too many attempts. Please wait and try again.';
    } else if (error.toString().contains('Could not send email verification')) {
      return 'Failed to send verification email. Please try again.';
    }
    return 'An error occurred. Please try again.';
  }
}