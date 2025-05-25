import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/models/brand_model.dart';

import '../../../exceptions/firebase/firebase_exception.dart';
import '../../../exceptions/platform/platform_exception.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  //variable
  final _db = FirebaseFirestore.instance;

  //get all categories
  Future<List<BrandModel>> getAllBrands() async{
    try {
      final snapshot = await  _db.collection('brands').get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
//get brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async{
    try {
      //query to get all documents where categoryId matches
      QuerySnapshot brandCategoryQuery = await _db.collection('brandCategory').where('categoryId', isEqualTo: categoryId).get();

      //extract brandId from the documents
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

      //query to get brandId from brandIds
      final brandsQuery = await _db.collection('brands').where(FieldPath.documentId,whereIn: brandIds).limit(2).get();

      //extract brand names or other relevant data from the documents
      List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
