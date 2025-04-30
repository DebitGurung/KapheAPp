import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/banners/banner_repository.dart';
import 'package:kapheapp/features/shop/models/banner_model.dart';

import '../../../utils/popups/loaders.dart';

class BannerController extends GetxController {
  //variables
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }
  //update page navigational dots
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  //fetch banners

//load category data
  Future<void> fetchBanners() async {
    try {
      //show loader while loading categories
      isLoading.value = true;

      //fetch banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      //assign banners
      this.banners.assignAll(banners);

    } catch (e) {
      TLoader.errorSnackBar(
          title: 'Sorry something went wrong', message: e.toString());
    } finally {
      //remove loader
      isLoading.value = false;
    }
  }
}
