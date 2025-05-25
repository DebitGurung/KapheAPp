import 'package:flutter/foundation.dart';

@immutable
class CafeBranchModel {
  final String id;
  final String name;
  final String image;
  final bool isFeatured;
  final int branchCount;

  const CafeBranchModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.branchCount = 0,
  });

  static CafeBranchModel empty() => const CafeBranchModel(
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
      'branchCount': branchCount,
    };
  }

  factory CafeBranchModel.fromJson(Map<String, dynamic> json) {
    try {
      if (json.isEmpty) return CafeBranchModel.empty();

      return CafeBranchModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        image: json['image'] as String? ?? '',
        isFeatured: json['isFeatured'] as bool? ?? false,
        branchCount: (json['branchCount'] as num?)?.toInt() ?? 0,
      );
    } catch (e) {
      throw FormatException('Failed to parse CafeBranchModel: $e');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CafeBranchModel &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.isFeatured == isFeatured &&
        other.branchCount == branchCount;
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    image,
    isFeatured,
    branchCount,
  );
}