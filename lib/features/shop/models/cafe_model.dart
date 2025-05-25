import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kapheapp/features/shop/models/branch_model.dart';
import 'package:kapheapp/features/shop/models/product_attribute_model.dart';
import 'package:kapheapp/features/shop/models/product_variation_model.dart';

@immutable
class CafeModel {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final String thumbnail;
  final bool isFeatured;
  final BranchModel? branch;
  final List<String> images;
  final List<ProductAttributeModel> attributes;
  final List<ProductVariationModel> variations;
  final DateTime dateAdded;
  final String address;
  final String openingHours;

  const CafeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.thumbnail,
    this.isFeatured = false,
    this.images = const [],
    this.attributes = const [],
    this.variations = const [],
    required this.dateAdded,
    required this.address,
    required this.openingHours,
    this.branch,
  });

  static CafeModel empty() => CafeModel(
    id: '',
    title: '',
    description: '',
    categoryId: '',
    thumbnail: '',
    dateAdded: DateTime.now(),
    address: '',
    openingHours: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'thumbnail': thumbnail,
      'isFeatured': isFeatured,
      'images': images,
      'attributes': attributes.map((a) => a.toJson()).toList(),
      'variations': variations.map((v) => v.toJson()).toList(),
      'dateAdded': dateAdded.millisecondsSinceEpoch,
      'address': address,
      'openingHours': openingHours,
      'branch': branch?.toJson(), // Handle nullable branch
    };
  }

  factory CafeModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) return CafeModel.empty();

    return CafeModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      categoryId: data['categoryId'] as String? ?? '',
      thumbnail: data['thumbnail'] as String? ?? '',
      isFeatured: data['isFeatured'] as bool? ?? false,
      images: List<String>.from(data['images'] as List<dynamic>? ?? []),
      attributes: (data['attributes'] as List<dynamic>?)
          ?.map((e) => ProductAttributeModel.fromJson(e))
          .toList() ??
          [],
      variations: (data['variations'] as List<dynamic>?)
          ?.map((e) => ProductVariationModel.fromJson(e))
          .toList() ??
          [],
      dateAdded: DateTime.fromMillisecondsSinceEpoch(
          data['dateAdded'] as int? ?? DateTime.now().millisecondsSinceEpoch),
      address: data['address'] as String? ?? '',
      openingHours: data['openingHours'] as String? ?? '',
      branch: data['branch'] != null ? BranchModel.fromJson(data['branch']) : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CafeModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.categoryId == categoryId &&
        other.thumbnail == thumbnail &&
        other.isFeatured == isFeatured &&
        other.address == address &&
        other.openingHours == openingHours &&
        other.branch == branch &&
        listEquals(other.images, images) &&
        listEquals(other.attributes, attributes) &&
        listEquals(other.variations, variations) &&
        other.dateAdded == dateAdded;
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    title,
    description,
    categoryId,
    thumbnail,
    isFeatured,
    images,
    attributes,
    variations,
    dateAdded,
    address,
    openingHours,
    branch,
  ]);
}