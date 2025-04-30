import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //sendEmailVerification link

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoader.successSnackBar(
          title: 'Email sent', message: 'Please check your email inbox');
    } catch (e) {
      TLoader.errorSnackBar(
          title: 'Something went wrong', message: e.toString());
    }
  }

  //timer to auto redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.reload();
        if (user.emailVerified) {
          timer.cancel();
          Get.off(() => SuccessScreen(
            image: TImages.successfullyRegisterAnimation,
            title: TText.yourAccountCreatedTitle,
            subTitle: TText.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect(),
          ));
        }
      } else {
        timer.cancel(); // Optional: Stop the timer if no user is signed in
        TLoader.errorSnackBar(
          title: 'Error',
          message: 'No user is currently signed in.',
        );
      }
    });
  }


//manually check if email is verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
        image: TImages.successfullyRegisterAnimation,
        title: TText.yourAccountCreatedTitle,
        subTitle: TText.yourAccountCreatedSubTitle,
        onPressed: () =>
            AuthenticationRepository.instance.screenRedirect(),
      ));
    }
  }
}
