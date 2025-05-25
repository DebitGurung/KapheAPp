import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  // Get all images from product and variations
  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};
    images.add(product.thumbnail);
    selectedProductImage.value = product.thumbnail;

    images.addAll(product.images);

    if (product.variations.isNotEmpty) {
      images.addAll(product.variations.map((variation) => variation.image));
    }

    return images.toList();
  }

  // Show enlarged image in a fullscreen dialog
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: GestureDetector(
          onTap: () => Get.back(),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.contain,
            errorWidget: (_, __, ___) => const Center(
              child: Icon(Icons.broken_image, size: 50),
            ),
          ),
        ),
      ),
    );
  }
}