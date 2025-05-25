import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../cloudinary/services/cloudinary_storage_service.dart';
import '../../../exceptions/firebase/firebase_exception.dart';
import '../../../exceptions/format/format_exception.dart';
import '../../../exceptions/platform/platform_exception.dart';
import '../../../features/shop/models/cafe_category_model.dart';
class CafeCategoryRepository extends GetxController {
  static CafeCategoryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<CafeCategoryModel>> getAllCafeCategories() async {
    try {
      final snapshot = await _db.collection('Cafe_Category').get();
      return snapshot.docs.map((doc) => CafeCategoryModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!';
    }
  }

  Future<void> uploadDummyData(List<CafeCategoryModel> categories) async {
    try {
      final storage = Get.find<TCloudinaryStorageService>();

      // Parallel uploads
      final uploadFutures = categories.map((category) async {
        final file = await storage.getImageDataFromAssets(category.image);
        final fileName = sanitizeFileName(category.name);
        final url = await storage.uploadImageData('Cafe_Category', file, fileName);
        category.image = url;
        return category;
      }).toList();

      final updatedCategories = await Future.wait(uploadFutures);

      // Batch write to Fire store
      final batch = _db.batch();
      for (final category in updatedCategories) {
        final docRef = _db.collection('Cafe_Category').doc();
        batch.set(docRef, category.toJson());
      }
      await batch.commit();

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on SocketException catch (e) {
      throw 'Network error: ${e.message}';
    } catch (e) {
      throw 'Failed to upload dummy data: $e';
    }
  }

  String sanitizeFileName(String name) {
    return name.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_').toLowerCase();
  }
}