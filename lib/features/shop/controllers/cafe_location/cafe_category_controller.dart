import 'package:get/get.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

import '../../../../data/repositories/cafe_categories/cafe_category_repository.dart';
import '../../models/cafe_category_model.dart';

class CafeCategoryController extends GetxController {
  static CafeCategoryController get instance => Get.find();

  // Repositories
  final _cafeCategoryRepository = Get.put(CafeCategoryRepository());

  // Observables
  final isLoading = false.obs;
  final isFeaturedLoading = false.obs;
  final selectedCategory = Rx<CafeCategoryModel?>(null);
  final RxList<CafeCategoryModel> allCafeCategories = <CafeCategoryModel>[].obs;
  final RxList<CafeCategoryModel> featuredCafeCategories = <CafeCategoryModel>[].obs;
  final RxList<CafeCategoryModel> filteredCafeCategories = <CafeCategoryModel>[].obs;
  final RxString searchQuery = ''.obs;

  // Configuration
  final int featuredLimit = 4;
  final int paginationLimit = 10;
  var currentPage = 0.obs;
  var totalCategories = 0.obs;

  @override
  void onInit() {
    fetchInitialCategories();
    ever(searchQuery, (_) => filterCategories());
    super.onInit();
  }

  Future<void> fetchInitialCategories() async {
    try {
      isLoading.value = true;
      final result = await _cafeCategoryRepository.getAllCafeCategories();
      allCafeCategories.assignAll(result);
      totalCategories.value = result.length;
      _updateFeaturedCategories();
      filterCategories();
    } catch (e) {
      _handleError(e, 'Failed to fetch initial categories');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreCategories() async {
    if ((currentPage.value + 1) * paginationLimit < totalCategories.value) {
      currentPage.value++;
      // TODO: Implement pagination logic in repository (e.g., Firestore query with limit and startAfter)
    }
  }

  void _updateFeaturedCategories() {
    featuredCafeCategories.assignAll(
      allCafeCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(featuredLimit)
          .toList(),
    );
  }

  void filterCategories() {
    if (searchQuery.value.isEmpty) {
      filteredCafeCategories.assignAll(allCafeCategories);
    } else {
      filteredCafeCategories.assignAll(
        allCafeCategories
            .where((category) => category.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
            .toList(),
      );
    }
  }

  List<CafeCategoryModel> getSubcategories(String parentId) {
    return allCafeCategories.where((category) => category.parentId == parentId).toList();
  }

  void selectCategory(CafeCategoryModel? category) {
    selectedCategory.value = category;
  }

  Future<void> refreshCategories() async {
    currentPage.value = 0;
    await fetchInitialCategories();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void _handleError(dynamic error, String fallbackMessage) {
    TLoader.errorSnackBar(
      title: 'Operation Failed',
      message: error is String ? error : error.toString(),
    );
    // TODO: Log error to analytics (e.g., Firebase Crashlytics)
  }

  // Getters
  bool get hasFeaturedCategories => featuredCafeCategories.isNotEmpty;
  bool get showLoadingMore => !isLoading.value && filteredCafeCategories.length < totalCategories.value;

// Note: popularCafeItems is not defined; use featuredCafeCategories for popular cafes display
}