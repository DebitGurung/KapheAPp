import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/products/product_repository.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Popular'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) {
        if (kDebugMode) print('Query is null, returning empty list.');
        return [];
      }
      if (kDebugMode) print('Fetching products with query...');
      final products = await repository.fetchProductsByQuery(query);
      if (kDebugMode) print('Fetched ${products.length} products.');
      return products;
    } catch (e) {
      if (kDebugMode) print('Error in fetchProductsByQuery: $e');
      TLoader.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;
    if (kDebugMode) print('Sorting products by $sortOption');

    switch (sortOption) {
      case 'Popular':
        products.sort((a, b) => a.title.compareTo(b.title)); // Adjust if popularity is a field
        break;
      case 'Relaxing drink':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Refreshing drinks':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Dripped coffee':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Discounts on':
        products.sort((a, b) {
          if (b.discount > 0) {
            return b.discount.compareTo(a.discount);
          } else if (a.discount > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProduct(List<ProductModel> products) {
    if (kDebugMode) print('Assigning ${products.length} products.');
    this.products.assignAll(products);
    sortProducts('Popular');
  }
}