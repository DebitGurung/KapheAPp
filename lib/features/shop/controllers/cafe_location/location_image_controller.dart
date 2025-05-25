import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/shop/models/cafe_model.dart';

class LocationImageController extends GetxController {
  static LocationImageController get instance => Get.find();

  RxString selectedLocationImage = ''.obs;

  List<String> getAllLocationImages(CafeModel cafe) {
    final Set<String> images = {};

    // Handle thumbnail
    if (cafe.thumbnail.isNotEmpty) {
      images.add(cafe.thumbnail);
      selectedLocationImage.value = cafe.thumbnail;
    }

    // Handle images collection
    images.addAll(cafe.images.where((img) => img.isNotEmpty));

    // Handle variations
    images.addAll(cafe.variations
        .where((v) => v.image.isNotEmpty)
        .map((v) => v.image));

    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: GestureDetector(
          onTap: Get.back,
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