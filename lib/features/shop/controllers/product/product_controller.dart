import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kapheapp/utils/popups/loaders.dart';
import 'package:kapheapp/utils/formatters/formatter.dart';
import '../../../../data/repositories/products/product_repository.dart';
import '../../models/product_model.dart';


class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.find<ProductRepository>();
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  bool _hasFetched = false;

  @override
  void onInit() {
    if (!_hasFetched) {
      fetchFeaturedProducts();
    }
    super.onInit();
  }

  Future<void> fetchFeaturedProducts() async {
    if (_hasFetched) {
      if (kDebugMode) print('Fetch already completed, skipping...');
      return;
    }
    try {
      if (kDebugMode) print('Starting fetchFeaturedProducts for all featured products...');
      isLoading.value = true;
      final products = await productRepository.getAllFeaturedProducts();
      if (products.isEmpty) {
        if (kDebugMode) print('No featured products fetched. Check Firestore for isFeatured: true documents.');
      } else {
        if (kDebugMode) print('Successfully fetched ${products.length} products: ${products.map((p) => p.id).join(', ')}');
        for (var product in products) {
          if (kDebugMode) print('Product: ${product.id}, Title: ${product.title}, isFeatured: ${product.isFeatured}, Price: ${product.price}, Thumbnail: ${product.thumbnail}');
        }
      }
      featuredProducts.assignAll(products);
      _hasFetched = true;
    } catch (e) {
      if (kDebugMode) print('Error in fetchFeaturedProducts: $e');
      TLoader.errorSnackBar(
        title: 'Oops something went wrong!',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
      if (kDebugMode) print('Fetch complete. featuredProducts length: ${featuredProducts.length}');
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final products = await productRepository.getAllFeaturedProducts();
      return products;
    } catch (e) {
      TLoader.errorSnackBar(
        title: 'Oops something went wrong!',
        message: e.toString(),
      );
      return [];
    }
  }

  String getProductPrice(ProductModel product) {
    if (product.beverageType == 'single') {
      final price = (product.discount > 0 && product.discount < product.price)
          ? product.discount
          : product.price;
      return TFormatter.formatCurrency(price);
    }

    if (product.variations.isEmpty) {
      return TFormatter.formatCurrency(product.price);
    }

    double minPrice = double.infinity;
    double maxPrice = 0;

    for (final variation in product.variations) {
      final price =
      (variation.discount > 0 && variation.discount < variation.price)
          ? variation.discount
          : variation.price;
      minPrice = min(minPrice, price);
      maxPrice = max(maxPrice, price);
    }

    return minPrice == maxPrice
        ? TFormatter.formatCurrency(maxPrice)
        : '${TFormatter.formatCurrency(minPrice)} - ${TFormatter.formatCurrency(maxPrice)}';
  }

  String? calculateDiscountPercentage(
      double originalPrice, double? discountPrice) {
    if (discountPrice == null ||
        discountPrice <= 0 ||
        originalPrice <= 0 ||
        discountPrice >= originalPrice) {
      return null;
    }

    final percentage = ((originalPrice - discountPrice) / originalPrice) * 100;
    return '${percentage.toStringAsFixed(percentage.truncateToDouble() == percentage ? 0 : 1)}%';
  }

  String getBeverageAvailabilityStatus(int stock) {
    if (stock < 0) {
      debugPrint('Invalid stock value: $stock');
      return 'Availability Unknown';
    }

    final isAvailable = stock > 0;
    final isCurrentlyAvailable = true;

    return isAvailable && isCurrentlyAvailable ? 'Available' : 'Not Available';
  }

  String getProductDeliveryTime() {
    return 'Delivery within ${Random().nextInt(5) + 1}-${Random().nextInt(10) + 6} days';
  }
}