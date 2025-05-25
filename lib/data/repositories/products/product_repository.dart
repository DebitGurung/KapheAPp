import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kapheapp/exceptions/firebase/firebase_exception.dart';
import 'package:kapheapp/exceptions/platform/platform_exception.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      if (kDebugMode) print('Fetching all featured products from Firestore...');
      var snapshot = await _db
          .collection('products')
          .where('isFeatured', isEqualTo: true)
          .get();

      if (kDebugMode) print('Query snapshot (isFeatured: true) returned ${snapshot.docs.length} documents.');
      if (snapshot.docs.isEmpty) {
        if (kDebugMode) print('No documents found with isFeatured: true. Falling back to fetch all products for debugging...');
        snapshot = await _db.collection('products').get();
        if (kDebugMode) print('Fallback query returned ${snapshot.docs.length} documents.');
      }

      for (var doc in snapshot.docs) {
        if (kDebugMode) print('Raw document data for ${doc.id}: ${doc.data()}');
      }

      final products = snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .where((product) => product.isFeatured)
          .toList();

      if (kDebugMode) print('Parsed ${products.length} featured products: ${products.map((p) => p.id).join(', ')}');
      return products;
    } on FirebaseException catch (e) {
      if (kDebugMode) print('FirebaseException in getAllFeaturedProducts: ${e.code} - ${e.message}');
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      if (kDebugMode) print('PlatformException in getAllFeaturedProducts: ${e.code} - ${e.message}');
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Unknown error in getAllFeaturedProducts: $e');
      throw 'Something went wrong. Please try again';
    }
  }

  // Other methods remain unchanged
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((docs) => ProductModel.fromQuerySnapshot(docs))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadDummyData(List<ProductModel> products, {Duration delay = const Duration(seconds: 1)}) async {
    try {
      if (products.isEmpty) throw 'No products provided for upload';
      for (var product in products) {
        if (product.id.isEmpty) {
          throw 'Product ID cannot be empty for ${product.title}';
        }
      }

      const batchSize = 500;
      for (var i = 0; i < products.length; i += batchSize) {
        final batch = _db.batch();
        final chunk = products.sublist(
          i,
          i + batchSize > products.length ? products.length : i + batchSize,
        );

        for (final product in chunk) {
          final docRef = _db.collection('products').doc(product.id);
          batch.set(docRef, product.toJson());
        }

        await batch.commit();
        if (kDebugMode) {
          print('Uploaded batch ${i ~/ batchSize + 1} of ${(products.length / batchSize).ceil()}');
        }
        if (i + batchSize < products.length) {
          await Future.delayed(delay);
        }
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Failed to upload products: ${e.toString()}';
    }
  }

  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<ProductModel?> getProductById(String productId) async {
    try {
      if (productId.isEmpty) throw 'Product ID cannot be empty';
      final doc = await _db.collection('products').doc(productId).get();
      if (!doc.exists) return null;
      return ProductModel.fromSnapshot(doc);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Product not found: ${e.toString()}';
    }
  }

  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
          .collection('products')
          .where('brand.id', isEqualTo: brandId)
          .get()
          : await _db
          .collection('products')
          .where('brand.id', isEqualTo: brandId)
          .limit(limit)
          .get();

      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit = 4}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
          .collection('productCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get()
          : await _db
          .collection('productCategory')
          .where('categoryId', isEqualTo: categoryId)
          .limit(limit)
          .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      final productQuery = await _db
          .collection('products')
          .where(FieldPath.documentId, whereIn: productIds)
          .limit(2)
          .get();

      List<ProductModel> products = productQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}