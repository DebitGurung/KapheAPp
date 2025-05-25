import 'package:cloud_firestore/cloud_firestore.dart';

class CafeCategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;


  CafeCategoryModel(
      {required this.id,
        required this.name,
        required this.image,
        required this.isFeatured,
        this.parentId = '',

        });
  // In CategoryModel class
  CafeCategoryModel copyWith({String? image}) {
    return CafeCategoryModel(
      id: id,
      name: name,
      image: image ?? this.image,
      isFeatured: isFeatured,
      parentId: parentId,


    );
  }

  //empty helper function
  static CafeCategoryModel empty() =>
      CafeCategoryModel(id: "", name: "", image: "", isFeatured: false);

  //convert model to json structure so that you can store data in firestore

  Map<String, dynamic> toJson() {
    return {
      'Image': image,
      'Name': name,
      'ParentId': parentId,

    };
  }

//map json oriented document snapshot from firebase to userModel
  factory CafeCategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      //map json record to the model
      return CafeCategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,


      );
    } else {
      return CafeCategoryModel.empty();
    }
  }
}
