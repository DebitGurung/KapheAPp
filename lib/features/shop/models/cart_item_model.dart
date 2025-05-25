import 'package:kapheapp/features/shop/models/brand_model.dart';

class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  BrandModel? brand; // Changed from brandName to brand
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    this.image,
    required this.quantity,
    required this.variationId,
    this.brand,
    this.selectedVariation,
  });

  factory CartItemModel.empty() {
    return CartItemModel(
      productId: '',
      title: '',
      price: 0.0,
      quantity: 0,
      variationId: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brand': brand?.toJson(),
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'],
      quantity: json['quantity'] ?? 0,
      variationId: json['variationId'] ?? '',
      brand: json['brand'] != null ? BrandModel.fromJson(json['brand']) : null,
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
    );
  }
}

extension CartItemModelExtension on CartItemModel {
  CartItemModel copyWith({
    String? productId,
    String? title,
    double? price,
    String? image,
    int? quantity,
    String? variationId,
    BrandModel? brand,
    Map<String, String>? selectedVariation,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      variationId: variationId ?? this.variationId,
      brand: brand ?? this.brand,
      selectedVariation: selectedVariation ?? this.selectedVariation,
    );
  }
}