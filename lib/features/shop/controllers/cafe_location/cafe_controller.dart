import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/cafe/cafe_repository.dart';
import 'package:kapheapp/features/shop/models/cafe_model.dart';
import 'package:kapheapp/utils/popups/loaders.dart';


class CafeController extends GetxController {
  static CafeController get instance => Get.find();

  final isLoading = false.obs;
  final cafeRepository = Get.put(CafeRepository());
  RxList<CafeModel> featuredCafes = <CafeModel>[].obs;
  RxList<CafeModel> allCafes = <CafeModel>[].obs;

  @override
  void onInit() {
    // Initial fetch deferred until a branchId is provided
    super.onInit();
  }

  /// Fetch featured cafes for a specific branch
  Future<void> fetchFeaturedCafes(String branchId) async {
    try {
      isLoading.value = true;
      final cafes = await cafeRepository.getFeaturedCafes(branchId); // Updated method name
      featuredCafes.assignAll(cafes);
    } catch (e) {
      TLoader.errorSnackBar(title: 'Error', message: 'Failed to load featured cafes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch all cafes for a specific branch
  Future<void> fetchAllCafes(String branchId) async {
    try {
      isLoading.value = true;
      final cafes = await cafeRepository.getAllCafes(branchId);
      allCafes.assignAll(cafes);
    } catch (e) {
      TLoader.errorSnackBar(title: 'Error', message: 'Failed to load cafes: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch a single cafe by ID for a specific branch
  Future<CafeModel?> fetchCafeById(String branchId, String cafeId) async {
    try {
      isLoading.value = true;
      final cafe = await cafeRepository.getCafeById(branchId, cafeId);
      return cafe;
    } catch (e) {
      TLoader.errorSnackBar(title: 'Error', message: 'Failed to load cafe: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}