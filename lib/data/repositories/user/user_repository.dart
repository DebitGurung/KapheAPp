import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/authentication/authentication_repository.dart';

import '../../../exceptions/firebase/firebase_exception.dart';
import '../../../exceptions/format/format_exception.dart';
import '../../../exceptions/platform/platform_exception.dart';
import 'user_model.dart';

class UserRepository {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save or update user with merge
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'Platform error');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Fetch user details with auth check
  Future<UserModel> fetchUserDetail() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'Platform error');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Partial update using update()
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'Platform error');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Update single field
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'Platform error');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Delete user record
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'Platform error');
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Upload image with error handling

  Future<String> uploadImage(String folderPath, String filePath) async {
    try {
      if (folderPath.isEmpty || filePath.isEmpty) {
        throw TFormatException('Folder or file path is invalid.');
      }

      final cloudinary = Get.find<Cloudinary>();
      final response = await cloudinary.uploadResource(
        CloudinaryUploadResource(
          filePath: filePath,
          folder: folderPath,
          resourceType: CloudinaryResourceType.image,
        ),
      );

      if (response.secureUrl == null) {
        throw 'Image upload succeeded, but no URL was returned.';
      }

      return response.secureUrl!;
    } on SocketException catch (e) {
      throw 'Network error: ${e.message}';
    } on FormatException catch (e) {
      throw TFormatException(e.message);
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'Platform error');
    } catch (e) {
      throw 'Image upload failed: ${e.toString()}';
    }
  }
}
