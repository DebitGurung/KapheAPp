import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  late final String image;
  final String parentId;
  final bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? image,
    String? parentId,
    bool? isFeatured,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      parentId: parentId ?? this.parentId,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFeatured': isFeatured,
    };
  }

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return CategoryModel(
        id: document.id,
        name: data['name'] as String? ?? '', // Fixed: Use 'name' instead of 'determination'
        image: data['image'] as String? ?? '',
        parentId: data['parentId'] as String? ?? '',
        isFeatured: data['isFeatured'] as bool? ?? false,
      );
    }
    return CategoryModel.empty();
  }
}