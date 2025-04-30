import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/authentication/authentication_repository.dart';
import 'package:kapheapp/data/repositories/user/user_repository.dart';
import 'package:kapheapp/network_manager/network_manager.dart';
import 'package:kapheapp/utils/popups/full_screen_loader.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

import '../../../data/repositories/user/user_model.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../authentication/screens/login/login.dart';
import '../screens/profile/widgets/re_authenticate_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs; //loading state for profile
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final imageUploading = false.obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  FilePickerResult? image;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetail();
      this.user(user);
    } catch (e) {
      user(UserModel.empty()); // Set default empty user on error
    } finally {
      profileLoading.value = false;
    }
  }

  //save user record from any registration provider

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //refresh user record
      //first update rx user and then check if the user data is already
      // stored, if not store new data
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          //convert name to first and last name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUserName(
              userCredentials.user!.displayName ?? '');

          //map data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join('') : ' ',
            userName: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );
          //save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoader.warningSnackBar(
          title: 'Data is not saved',
          message:
              'Something went wrong while saving information. You can re-save your data in your profile.');
    }
  }

  //delete user account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account? This action cannot be undone.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  //delete user account

  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      //first re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //Re verify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.warningSnackBar(
          title: 'Sorry there was a problem', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.docerAnimation);

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoader.warningSnackBar(
          title: 'Sorry there was a problem', message: e.toString());
    }
  }

// UserController.dart - Updated uploadUserProfilePicture method
  FilePickerResult? selectedFile;

  uploadUserProfilePicture() async {
    try {
      // Pick file using FilePicker
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result == null || result.files.isEmpty) return;

      selectedFile = result;
      imageUploading.value = true;

      // Get file path
      final filePath = selectedFile!.files.single.path!;
      final imageUrl = await userRepository.uploadImage(
        'User/Images/Profile/',
        filePath,
      );

      // Update user image
      Map<String, dynamic> json = {'ProfilePicture': imageUrl};
      await userRepository.updateSingleField(json);

      user.value.profilePicture = imageUrl;
      user.refresh();

      TLoader.successSnackBar(
        title: 'Profile picture updated',
        message: 'Your profile picture has been updated successfully',
      );
    } catch (e) {
      TLoader.errorSnackBar(
        title: 'Sorry there was a problem',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }
}
