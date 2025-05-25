// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kapheapp/utils/local_storage/storage_utility.dart';

import '../../../exceptions/firebase/firebase_auth_exception.dart';
import '../../../exceptions/firebase/firebase_exception.dart';
import '../../../exceptions/format/format_exception.dart';
import '../../../exceptions/platform/platform_exception.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onBoarding/onboarding.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../navigation/navigation_menu.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get authenticated user
  User? get authUser => _auth.currentUser;

  // Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    Future.delayed(const Duration(milliseconds: 300), () {
      screenRedirect();
    });
  }

  // Redirect to screen based on authentication
  void screenRedirect() async {
    try {
      final isFirstTime = deviceStorage.read('isFirstTime') as bool? ?? true;
      final user = _auth.currentUser;

      if (user != null) {
        // Reload user to get the latest email verification status
        await user.reload();
        final updatedUser = _auth.currentUser;

        if (updatedUser != null && !updatedUser.emailVerified) {
          await TLocalStorage.init(updatedUser.uid);
          Get.offAll(() => VerifyEmailScreen(email: updatedUser.email));
        } else {
          await TLocalStorage.init(updatedUser!.uid);
          Get.find<NavigationController>().selectedIndex.value = 0;
          Get.offAll(() => const NavigationMenu());
        }
      } else {
        if (isFirstTime) {
          Get.offAll(() => const OnBoardingScreen());
          deviceStorage.write('isFirstTime', false);
        } else {
          Get.offAll(() => const LoginScreen());
        }
      }
    } catch (e) {
      debugPrint('Screen Redirect Error: $e');
      Get.offAll(() => const LoginScreen());
    }
  }

  // Login with email and password
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Send email for verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.message}');
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      debugPrint('FirebaseException: ${e.message}');
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      debugPrint('Error sending email verification: $e');
      throw 'Could not send email verification. Please try again.';
    }
  }

  /* --------------------------- Federated Identity & Social Sign-In --------------------------- */
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      if (userAccount == null) throw TPlatformException('Sign-in cancelled');

      final googleAuth = await userAccount.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  /* --------------------------- Logout & Delete Account --------------------------- */
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Error signing out. Please try again.';
    }
  }

  /* Email authentication forgot password */
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Could not send password reset email. Please try again.';
    }
  }

  // Re-authenticate user
  Future<void> reAuthenticateEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
      EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser?.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Delete user account
  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw TFirebaseAuthException('no_user');

      await _auth.currentUser!.delete();
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw TFirebaseException('delete_failed');
    }
  }
}