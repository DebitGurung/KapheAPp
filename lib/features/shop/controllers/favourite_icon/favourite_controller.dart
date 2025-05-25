import 'dart:convert';

import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/products/product_repository.dart';
import 'package:kapheapp/utils/local_storage/storage_utility.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  //variables
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  //method to initialize favourites by reading from storage
  Future<void> initFavourites() async {
    final json = TLocalStorage.instance.readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouritesToStorage();
      TLoader.customToast(message: 'Product has been added to the wishlist.');
    } else {
      TLocalStorage.instance.removeData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      TLoader.customToast(message: 'Product has been removed to the wishlist.');
    }
  }

  void saveFavouritesToStorage() {
    final encodedFavourites = json.encode(favourites);
    TLocalStorage.instance.writeData('favourites', encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProduct() async{
    return await ProductRepository.instance.getFavouriteProducts(favourites.keys.toList());

  }

}
