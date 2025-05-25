import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/banners/banner_repository.dart';
import 'package:kapheapp/features/shop/models/banner_model.dart';
import 'package:kapheapp/cloudinary/services/cloudinary_storage_service.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final bannerRepo = BannerRepository.instance;
      final fetchedBanners = await bannerRepo.fetchBanners();
      // Removed print statement
      banners.assignAll(
          fetchedBanners.where((banner) => banner.imageUrl.isNotEmpty));
    } catch (e) {
      TLoader.errorSnackBar(
          title: 'Sorry something went wrong', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> uploadBanner({
    required String targetScreen,
    required bool active,
  }) async {
    try {
      isLoading.value = true;

      final cloudinaryService = TCloudinaryStorageService.instance;
      final imageUrl = await cloudinaryService.uploadImageFile('banners');

      if (imageUrl.isEmpty) {
        throw 'Failed to upload image to Cloudinary';
      }

      final banner = BannerModel(
        imageUrl: imageUrl,
        targetScreen: targetScreen,
        active: active,
      );
      await BannerRepository.instance.uploadBanners([banner]);

      await fetchBanners();

      TLoader.successSnackBar(
          title: 'Success', message: 'Banner uploaded successfully!');
    } catch (e) {
      TLoader.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}