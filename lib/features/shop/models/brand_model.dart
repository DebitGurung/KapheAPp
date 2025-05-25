import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class BrandModel {
  final String id;
  final String name;
  final String image;
  final bool isFeatured;
  final int productsCount;

  const BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.productsCount = 0,
  });

  static BrandModel empty() => const BrandModel(
        id: '',
        name: '',
        image: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'productsCount': productsCount,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return BrandModel.empty();

    return BrandModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      productsCount: int.parse((data['productsCount'] ?? 0).toString()),
    );
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BrandModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        productsCount: data['productCounts'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
      );
    } else {
      return BrandModel.empty();
    }
  }

  BrandModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isFeatured,
    int? productsCount,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      productsCount: productsCount ?? this.productsCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BrandModel &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.isFeatured == isFeatured &&
        other.productsCount == productsCount;
  }

  @override
  int get hashCode => Object.hash(
        id,
        name,
        image,
        isFeatured,
        productsCount,
      );

  @override
  String toString() => '''
   BrandModel(
  id: $id,
  name: $name,
  image: $image,
  isFeatured: $isFeatured,
  productsCount: $productsCount
)
''';
}
