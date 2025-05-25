import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  final String brandId;
  final String categoryId;


  BrandCategoryModel(
      {required this.brandId,
        required this.categoryId,

      });
  // In CategoryModel class
 Map<String, dynamic> toJson()
 {
   return {
     'brandId' : brandId,
     'categoryId': categoryId,
   };
 }




//map json oriented document snapshot from firebase to userModel
  factory BrandCategoryModel.fromSnapshot(
      DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return BrandCategoryModel(
      brandId: data['brandId'],
      categoryId: data['categoryId'] as String);
  }
}
