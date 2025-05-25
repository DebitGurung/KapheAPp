import 'package:get/get.dart';
import 'package:kapheapp/features/shop/models/category_model.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

import '../../../../data/repositories/categories/category_repository.dart';
import '../../../../data/repositories/products/product_repository.dart';
import '../../models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // Load category data
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source
      final categories = await _categoryRepository.getAllCategories();
      // Update the categories list
      allCategories.assignAll(categories);
      // Filter featured categories (including subcategories under 'category_001' for Beverage category)
      featuredCategories.assignAll(
        allCategories
            .where((category) => category.isFeatured && (category.parentId == 'category_001' || category.parentId.isEmpty))
            .toSet() // Remove duplicates
            .toList(), // Removed .take(4) to show all categories
      );
    } catch (e) {
      TLoader.errorSnackBar(
          title: 'Sorry something went wrong', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }

  // Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      TLoader.errorSnackBar(
          title: 'Sorry something went wrong!', message: e.toString());
      return [];
    }
  }

  // Get category or sub category
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      TLoader.errorSnackBar(title: 'Sorry something went wrong!', message: e.toString());
      return [];
    }
  }
}