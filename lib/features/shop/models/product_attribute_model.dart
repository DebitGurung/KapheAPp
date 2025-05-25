import 'package:flutter/cupertino.dart';

@immutable
class ProductAttributeModel {
  final String name;
  final List<String>? values;

  const ProductAttributeModel({
    required this.name,
    this.values = const [],
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'values': values,
  };

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductAttributeModel(
        name: json['name'] as String? ?? '',
        values: (json['values'] as List<dynamic>?)?.cast<String>() ?? [],
      );
    } catch (e) {
      throw FormatException('Failed to parse ProductAttributeModel: $e');
    }
  }
}