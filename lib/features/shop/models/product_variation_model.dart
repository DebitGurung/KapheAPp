import 'package:flutter/foundation.dart';

@immutable
class ProductVariationModel {
  final String id;
  final String image;
  final String description;
  final double price;
  final double discount;
  final String availability;
  final int stock;
  final Map<String, String> attributeValues;

  const ProductVariationModel({
    required this.id,
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.discount = 0.0,
    this.availability = '',
    this.stock = 0,
    required this.attributeValues,
  });

  static ProductVariationModel empty() => const ProductVariationModel(
    id: '',
    attributeValues: {},
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'description': description,
    'price': price,
    'discount': discount,
    'availability': availability,
    'stock' : stock,
    'attributeValues': attributeValues,
  };

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductVariationModel(
        id: json['id'] as String? ?? '',
        image: json['image'] as String? ?? '',
        description: json['description'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
        availability: json['availability'] as String? ?? '',
        stock: json['stock'] as int? ?? 0,
        attributeValues: _parseAttributeValues(json['attributeValues']),
      );
    } catch (e) {
      throw FormatException('Failed to parse ProductVariationModel: $e');
    }
  }

  static Map<String, String> _parseAttributeValues(dynamic data) =>
      data is Map
          ? Map<String, String>.fromEntries(
        data.entries
            .map((e) => MapEntry(e.key.toString(), e.value.toString())),
      )
          : {};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProductVariationModel &&
              other.id == id &&
              other.image == image &&
              other.description == description &&
              other.price == price &&
              other.discount == discount &&
              other.availability == availability &&
              other.stock == stock &&
              mapEquals(other.attributeValues, attributeValues);

  @override
  int get hashCode => Object.hash(
    id,
    image,
    description,
    price,
    discount,
    availability,
    stock,
    attributeValues,
  );
}