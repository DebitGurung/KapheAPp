import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/products/product_repository.dart';
import 'package:kapheapp/features/shop/models/brand_model.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';

import '../../../../data/repositories/brands/brand_repository.dart';
import '../../../../utils/popups/loaders.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured).take(4));
    } catch (e) {
      TLoader.errorSnackBar(title: 'Oops sorry!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

//get brands for category

//get brand specific products from your data
  Future<List<ProductModel>> getBrandProduct( {required String brandId, int limit = -1}) async {
  try{
    final products = await ProductRepository.instance.getProductsForBrand( brandId: brandId, limit: limit);
    return products;
  }catch (e){
    TLoader.errorSnackBar(title: 'Sorry something went wrong!', message: e.toString());
    return [];
  }
  }

  //get brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try{
      final brands = await brandRepository.getBrandsForCategory( categoryId );
      return brands;
    }catch (e){
      TLoader.errorSnackBar(title: 'Sorry something went wrong!', message: e.toString());
      return [];
    }
  }


}
