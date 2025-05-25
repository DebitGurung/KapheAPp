import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/models/category_model.dart';
import '../../../cloudinary/services/cloudinary_storage_service.dart';
import '../../../exceptions/firebase/firebase_exception.dart';
import '../../../exceptions/format/format_exception.dart';
import '../../../exceptions/platform/platform_exception.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('categories').get();
      final list = snapshot.docs
          .map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Failed to fetch categories: $e (${e.runtimeType})';
    }
  }

  //get subcategories
  Future <List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db.collection('categories')
    .where('parentId', isEqualTo: categoryId).get();
    final result = snapshot.docs
        .map((e) => CategoryModel.fromSnapshot(e))
        .toList();
    return result;
    } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
    } on FormatException {
    throw const TFormatException();
    } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
    } catch (e) {
    throw 'Failed to fetch categories: $e (${e.runtimeType})';
    }
  }


  /// Uploads dummy category data to Fire store with Cloudinary images
  ///
  /// [categories] : List of local CategoryModels with asset image paths
  ///
  /// Throws [Exception] if:
  /// - No categories provided
  /// - Image paths are invalid
  /// - Cloudinary/Fire store operations fail
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      if (categories.isEmpty) {
        throw Exception('No categories provided for upload');
      }

      final storage = Get.find<TCloudinaryStorageService>();

      // Parallel uploads
      final uploadFutures = categories.map((category) async {
        if (category.image.isEmpty) {
          throw Exception('Image path is empty for category: ${category.name}');
        }
        final file = await storage.getImageDataFromAssets(category.image);
        final fileName = sanitizeFileName(category.name);
        final url = await storage.uploadImageData(
            'Bev_Category', file, fileName);
        category.image = url; // Update image URL (mutable field)
        return category;
      }).toList();

      final updatedCategories = await Future.wait(uploadFutures);

      // Batch write to Fire store with limit handling
      const int batchLimit = 500;
      for (var i = 0; i < updatedCategories.length; i += batchLimit) {
        final batch = _db.batch();
        final batchCategories = updatedCategories.sublist(
          i,
          i + batchLimit > updatedCategories.length
              ? updatedCategories.length
              : i + batchLimit,
        );
        for (final category in batchCategories) {
          final docRef = _db.collection('categories').doc();
          batch.set(docRef, category.toJson());
        }
        await batch.commit();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on SocketException catch (e) {
      throw 'Network error: ${e.message}';
    } catch (e) {
      throw 'Failed to upload dummy data: $e (${e.runtimeType})';
    }
  }

  String sanitizeFileName(String name) {
    final uniqueSuffix = DateTime
        .now()
        .microsecondsSinceEpoch;
    return '${name}_$uniqueSuffix'
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')
        .substring(0, 100);
  }
}