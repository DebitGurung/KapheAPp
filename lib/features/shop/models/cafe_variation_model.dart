import 'package:flutter/foundation.dart';

class CafeVariationModel {
  final String id;
  final String image;
  final String description;
  final Map<String, String> attributeValues;

  CafeVariationModel({
    required this.id,
    this.image = '',
    this.description = '',
    required this.attributeValues,
  });

  static CafeVariationModel empty() => CafeVariationModel(
    id: '',
    attributeValues: {},
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'description': description,
      'attributeValues': attributeValues,
    };
  }

  factory CafeVariationModel.fromJson(Map<String, dynamic> json) {
    try {
      if (json.isEmpty) return CafeVariationModel.empty();

      return CafeVariationModel(
        id: json['id'] as String? ?? '',
        image: json['image'] as String? ?? '',
        description: json['description'] as String? ?? '',
        attributeValues: _parseAttributeValues(json['attributeValues']),
      );
    } catch (e) {
      throw FormatException('Failed to parse cAFEVariationModel: $e');
    }
  }

  static Map<String, String> _parseAttributeValues(dynamic data) {
    if (data is! Map) return {};
    return Map<String, String>.fromEntries(
      data.entries.map((e) => MapEntry(
        e.key.toString(),
        e.value.toString(),
      )),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CafeVariationModel &&
        other.id == id &&
        other.image == image &&
        other.description == description &&
        mapEquals(other.attributeValues, attributeValues);
  }

  @override
  int get hashCode => Object.hash(
    id,
    image,
    description,

    attributeValues,
  );
}