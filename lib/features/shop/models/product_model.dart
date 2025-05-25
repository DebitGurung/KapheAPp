import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kapheapp/features/shop/models/brand_model.dart';
import 'package:kapheapp/features/shop/models/product_attribute_model.dart';
import 'package:kapheapp/features/shop/models/product_variation_model.dart';
import 'package:collection/collection.dart';

@immutable
class ProductModel {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final String beverageType;
  final double price;
  final double discount;
  final String thumbnail;
  final bool isFeatured;
  final BrandModel? brandId;
  final List<String> images;
  final List<ProductAttributeModel> attributes;
  final List<ProductVariationModel> variations;
  final String availabilityStatus;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.beverageType,
    required this.price,
    this.discount = 0.0,
    required this.thumbnail,
    this.isFeatured = false,
    this.brandId,
    this.images = const [],
    this.attributes = const [],
    this.variations = const [],
    this.availabilityStatus = 'In Stock',
  });

  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    description: '',
    categoryId: '',
    beverageType: 'single',
    price: 0.0,
    thumbnail: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'beverageType': beverageType,
      'price': price,
      'discount': discount,
      'thumbnail': thumbnail,
      'isFeatured': isFeatured,
      'images': images,
      'brand': brandId?.toJson(),
      'productAttributes': attributes.isNotEmpty ? attributes.map((a) => a.toJson()).toList() : null,
      'productVariations': variations.map((v) => v.toJson()).toList(),
      'availabilityStatus': availabilityStatus,
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      if (kDebugMode) print('Firestore snapshot data is null for doc ID: ${doc.id}');
      return ProductModel.empty();
    }

    if (kDebugMode) print('Parsing document ${doc.id} with data: $data');

    bool isFeatured = false;
    if (data.containsKey('isFeatured')) {
      final featuredValue = data['isFeatured'];
      if (featuredValue is bool) {
        isFeatured = featuredValue;
      } else if (featuredValue is String) {
        isFeatured = featuredValue.toLowerCase() == 'true';
      }
    } else if (data.containsKey('featured')) {
      final featuredValue = data['featured'];
      if (featuredValue is bool) {
        isFeatured = featuredValue;
      } else if (featuredValue is String) {
        isFeatured = featuredValue.toLowerCase() == 'true';
      }
    }
    if (kDebugMode) print('isFeatured value for doc ID ${doc.id}: $isFeatured');

    final title = data['title'] as String? ?? data['name'] as String? ?? 'Untitled';
    if (kDebugMode) print('Title for doc ID ${doc.id}: $title');

    double price = 0.0;
    final priceValue = data['price'];
    if (priceValue is num) {
      price = priceValue.toDouble();
      if (kDebugMode) print('Parsed price num $priceValue to $price for doc ID ${doc.id}');
    } else if (priceValue is String) {
      price = double.tryParse(priceValue) ?? 0.0;
      if (kDebugMode) print('Parsed price string $priceValue to $price for doc ID ${doc.id}');
    } else {
      if (kDebugMode) print('Invalid or missing price for doc ID ${doc.id}: $priceValue, using default 0.0');
    }
    if (price <= 0) {
      if (kDebugMode) print('Price is zero or negative for doc ID ${doc.id}, using default');
    }

    final thumbnail = data['thumbnail'] as String? ?? data['image'] as String? ?? '';
    if (thumbnail.isEmpty) {
      if (kDebugMode) print('Missing thumbnail for doc ID ${doc.id}, using default placeholder');
    }

    List<ProductVariationModel> variations = [];
    try {
      final variationsData = data['productVariations'] as List<dynamic>? ?? [];
      if (kDebugMode) print('Raw productVariations data for doc ID ${doc.id}: $variationsData');
      variations = variationsData.map((varData) {
        if (kDebugMode) print('Processing variation data: $varData');
        final attrValues = varData['attributeValues'] as Map<String, dynamic>? ?? varData['attibuteValues'] as Map<String, dynamic>? ?? {};
        if (kDebugMode) print('Extracted attributeValues for variation: $attrValues');

        // Handle stock as either num or String
        int stock = 0;
        final stockValue = varData['stock'];
        if (stockValue is num) {
          stock = stockValue.toInt();
        } else if (stockValue is String) {
          stock = int.tryParse(stockValue) ?? 0;
        }
        if (kDebugMode) print('Parsed stock: $stockValue to $stock');

        // Handle price as either num or String
        double variationPrice = 0.0;
        final priceVal = varData['price'];
        if (priceVal is num) {
          variationPrice = priceVal.toDouble();
        } else if (priceVal is String) {
          variationPrice = double.tryParse(priceVal) ?? 0.0;
        }
        if (kDebugMode) print('Parsed variation price: $priceVal to $variationPrice');

        // Handle discount as either num or String
        double variationDiscount = 0.0;
        final discountVal = varData['discount'];
        if (discountVal is num) {
          variationDiscount = discountVal.toDouble();
        } else if (discountVal is String) {
          variationDiscount = double.tryParse(discountVal) ?? 0.0;
        }
        if (kDebugMode) print('Parsed variation discount: $discountVal to $variationDiscount');

        return ProductVariationModel(
          id: varData['id']?.toString() ?? '',
          image: varData['image']?.toString() ?? '',
          description: varData['description']?.toString() ?? '',
          price: variationPrice,
          discount: variationDiscount,
          availability: varData['availability']?.toString() ?? 'Out of Stock',
          stock: stock,
          attributeValues: attrValues.map((k, v) => MapEntry(k.toString(), v.toString())),
        );
      }).toList();
      if (kDebugMode) print('Parsed variations for doc ID ${doc.id}: ${variations.length} items');
    } catch (e, stackTrace) {
      if (kDebugMode) print('Error parsing variations for doc ID ${doc.id}: $e\n$stackTrace');
      variations = [];
    }

    final effectiveThumbnail = thumbnail.isEmpty && variations.isNotEmpty
        ? variations.first.image
        : thumbnail.isEmpty
        ? 'https://via.placeholder.com/150'
        : thumbnail;

    final beverageType = data['beverageType'] as String? ?? data['type'] as String? ?? 'single';
    final normalizedBeverageType = beverageType.toLowerCase().contains('variable')
        ? 'variable'
        : 'single';
    if (normalizedBeverageType != 'single' && normalizedBeverageType != 'variable') {
      if (kDebugMode) print('Invalid beverageType for doc ID ${doc.id}: $beverageType, defaulting to single');
    }
    if (kDebugMode) print('Normalized beverageType for doc ID ${doc.id}: $normalizedBeverageType');

    final brandData = data['brand'] as Map<String, dynamic>? ?? {};
    final brand = brandData.isNotEmpty ? BrandModel.fromJson(brandData) : null;
    if (kDebugMode) print('Brand data for doc ID ${doc.id}: ${brand?.toJson() ?? 'null'}');

    final images = List<String>.from(data['images'] as List<dynamic>? ?? []);

    List<ProductAttributeModel> attributes = [];
    final productAttributesData = data['productAttributes'];
    if (kDebugMode) print('productAttributes data for doc ID ${doc.id}: $productAttributesData');

    if (productAttributesData != null) {
      if (productAttributesData is Map<String, dynamic>) {
        attributes = [ProductAttributeModel.fromJson(productAttributesData)];
        if (kDebugMode) print('Parsed single productAttributes for doc ID ${doc.id}');
      } else if (productAttributesData is List<dynamic>) {
        attributes = productAttributesData
            .map((attr) => ProductAttributeModel.fromJson(attr as Map<String, dynamic>))
            .toList();
        if (kDebugMode) print('Parsed list of productAttributes for doc ID ${doc.id}: ${attributes.length} items');
      } else {
        if (kDebugMode) print('Unexpected productAttributes type for doc ID ${doc.id}: ${productAttributesData.runtimeType}');
      }
    }

    return ProductModel(
      id: doc.id,
      title: title,
      description: data['description'] as String? ?? '',
      categoryId: data['categoryId'] as String? ?? '',
      beverageType: normalizedBeverageType,
      price: price,
      discount: (data['discount'] is num
          ? (data['discount'] as num).toDouble()
          : double.tryParse(data['discount']?.toString() ?? '0.0') ?? 0.0),
      thumbnail: effectiveThumbnail,
      isFeatured: isFeatured,
      images: images,
      attributes: attributes,
      variations: variations,
      brandId: brand,
      availabilityStatus: data['availabilityStatus'] as String? ?? 'In Stock',
    );
  }

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    if (kDebugMode) print('Parsing query document ${document.id} with data: $data');

    bool isFeatured = false;
    if (data.containsKey('isFeatured')) {
      final featuredValue = data['isFeatured'];
      if (featuredValue is bool) {
        isFeatured = featuredValue;
      } else if (featuredValue is String) {
        isFeatured = featuredValue.toLowerCase() == 'true';
      }
    } else if (data.containsKey('featured')) {
      final featuredValue = data['featured'];
      if (featuredValue is bool) {
        isFeatured = featuredValue;
      } else if (featuredValue is String) {
        isFeatured = featuredValue.toLowerCase() == 'true';
      }
    }
    if (kDebugMode) print('isFeatured value for doc ID ${document.id}: $isFeatured');

    final title = data['title'] as String? ?? data['name'] as String? ?? 'Untitled';
    if (kDebugMode) print('Title for doc ID ${document.id}: $title');

    double price = 0.0;
    final priceValue = data['price'];
    if (priceValue is num) {
      price = priceValue.toDouble();
      if (kDebugMode) print('Parsed price num $priceValue to $price for doc ID ${document.id}');
    } else if (priceValue is String) {
      price = double.tryParse(priceValue) ?? 0.0;
      if (kDebugMode) print('Parsed price string $priceValue to $price for doc ID ${document.id}');
    } else {
      if (kDebugMode) print('Invalid or missing price for doc ID ${document.id}: $priceValue, using default 0.0');
    }
    if (price <= 0) {
      if (kDebugMode) print('Price is zero or negative for doc ID ${document.id}, using default');
    }

    final thumbnail = data['thumbnail'] as String? ?? data['image'] as String? ?? '';
    if (thumbnail.isEmpty) {
      if (kDebugMode) print('Missing thumbnail for doc ID ${document.id}, using default placeholder');
    }

    List<ProductVariationModel> variations = [];
    try {
      final variationsData = data['productVariations'] as List<dynamic>? ?? [];
      if (kDebugMode) print('Raw productVariations data for doc ID ${document.id}: $variationsData');
      variations = variationsData.map((varData) {
        if (kDebugMode) print('Processing variation data: $varData');
        final attrValues = varData['attributeValues'] as Map<String, dynamic>? ?? varData['attibuteValues'] as Map<String, dynamic>? ?? {};
        if (kDebugMode) print('Extracted attributeValues for variation: $attrValues');

        int stock = 0;
        final stockValue = varData['stock'];
        if (stockValue is num) {
          stock = stockValue.toInt();
        } else if (stockValue is String) {
          stock = int.tryParse(stockValue) ?? 0;
        }
        if (kDebugMode) print('Parsed stock: $stockValue to $stock');

        double variationPrice = 0.0;
        final priceVal = varData['price'];
        if (priceVal is num) {
          variationPrice = priceVal.toDouble();
        } else if (priceVal is String) {
          variationPrice = double.tryParse(priceVal) ?? 0.0;
        }
        if (kDebugMode) print('Parsed variation price: $priceVal to $variationPrice');

        double variationDiscount = 0.0;
        final discountVal = varData['discount'];
        if (discountVal is num) {
          variationDiscount = discountVal.toDouble();
        } else if (discountVal is String) {
          variationDiscount = double.tryParse(discountVal) ?? 0.0;
        }
        if (kDebugMode) print('Parsed variation discount: $discountVal to $variationDiscount');

        return ProductVariationModel(
          id: varData['id']?.toString() ?? '',
          image: varData['image']?.toString() ?? '',
          description: varData['description']?.toString() ?? '',
          price: variationPrice,
          discount: variationDiscount,
          availability: varData['availability']?.toString() ?? 'Out of Stock',
          stock: stock,
          attributeValues: attrValues.map((k, v) => MapEntry(k.toString(), v.toString())),
        );
      }).toList();
      if (kDebugMode) print('Parsed variations for doc ID ${document.id}: ${variations.length} items');
    } catch (e, stackTrace) {
      if (kDebugMode) print('Error parsing variations for doc ID ${document.id}: $e\n$stackTrace');
      variations = [];
    }

    final effectiveThumbnail = thumbnail.isEmpty && variations.isNotEmpty
        ? variations.first.image
        : thumbnail.isEmpty
        ? 'https://via.placeholder.com/150'
        : thumbnail;

    final beverageType = data['beverageType'] as String? ?? data['type'] as String? ?? 'single';
    final normalizedBeverageType = beverageType.toLowerCase().contains('variable')
        ? 'variable'
        : 'single';
    if (normalizedBeverageType != 'single' && normalizedBeverageType != 'variable') {
      if (kDebugMode) print('Invalid beverageType for doc ID ${document.id}: $beverageType, defaulting to single');
    }
    if (kDebugMode) print('Normalized beverageType for doc ID ${document.id}: $normalizedBeverageType');

    final brandData = data['brand'] as Map<String, dynamic>? ?? {};
    final brand = brandData.isNotEmpty ? BrandModel.fromJson(brandData) : null;
    if (kDebugMode) print('Brand data for doc ID ${document.id}: ${brand?.toJson() ?? 'null'}');

    final images = List<String>.from(data['images'] as List<dynamic>? ?? []);

    List<ProductAttributeModel> attributes = [];
    final productAttributesData = data['productAttributes'];
    if (kDebugMode) print('productAttributes data for doc ID ${document.id}: $productAttributesData');

    if (productAttributesData != null) {
      if (productAttributesData is Map<String, dynamic>) {
        attributes = [ProductAttributeModel.fromJson(productAttributesData)];
        if (kDebugMode) print('Parsed single productAttributes for doc ID ${document.id}');
      } else if (productAttributesData is List<dynamic>) {
        attributes = productAttributesData
            .map((attr) => ProductAttributeModel.fromJson(attr as Map<String, dynamic>))
            .toList();
        if (kDebugMode) print('Parsed list of productAttributes for doc ID ${document.id}: ${attributes.length} items');
      } else {
        if (kDebugMode) print('Unexpected productAttributes type for doc ID ${document.id}: ${productAttributesData.runtimeType}');
      }
    }

    return ProductModel(
      id: document.id,
      title: title,
      description: data['description'] as String? ?? '',
      categoryId: data['categoryId'] as String? ?? '',
      beverageType: normalizedBeverageType,
      price: price,
      discount: (data['discount'] is num
          ? (data['discount'] as num).toDouble()
          : double.tryParse(data['discount']?.toString() ?? '0.0') ?? 0.0),
      thumbnail: effectiveThumbnail,
      isFeatured: isFeatured,
      images: images,
      attributes: attributes,
      variations: variations,
      brandId: brand,
      availabilityStatus: data['availabilityStatus'] as String? ?? 'In Stock',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.categoryId == categoryId &&
        other.beverageType == beverageType &&
        other.price == price &&
        other.discount == discount &&
        other.thumbnail == thumbnail &&
        other.isFeatured == isFeatured &&
        other.brandId == brandId &&
        const DeepCollectionEquality().equals(other.images, images) &&
        const DeepCollectionEquality().equals(other.attributes, attributes) &&
        const DeepCollectionEquality().equals(other.variations, variations) &&
        other.availabilityStatus == availabilityStatus;
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    title,
    description,
    categoryId,
    beverageType,
    price,
    discount,
    thumbnail,
    isFeatured,
    brandId,
    images,
    attributes,
    variations,
    availabilityStatus,
  ]);
}