import 'package:get/get.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';
import 'package:kapheapp/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  final RxMap<String, String> selectedAttributes = <String, String>{}.obs;
  final RxDouble displayedPrice = 0.0.obs;
  final RxString displayedStockStatus = 'In Stock'.obs;
  final RxInt maxStock = 0.obs;
  final RxBool canIncrease = false.obs;
  final RxBool isVariationSelected = false.obs;
  final Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  late ProductModel product;

  void loadVariations(ProductModel product) {
    this.product = product;
    if (product.variations.isEmpty) {
      displayedPrice.value = product.price;
      displayedStockStatus.value = 'Currently Unavailable';
      maxStock.value = 0;
      canIncrease.value = false;
      isVariationSelected.value = false;
      selectedVariation.value = ProductVariationModel.empty();
      return;
    }

    if (selectedAttributes.isEmpty && product.attributes.isNotEmpty) {
      final firstAttr = product.attributes.first;
      final lastAttr = product.attributes.last;
      final firstAttrValue = firstAttr.values?.isNotEmpty == true ? firstAttr.values!.first : '';
      final lastAttrValue = lastAttr.values?.isNotEmpty == true ? lastAttr.values!.first : '';

      if (firstAttrValue.isNotEmpty && lastAttrValue.isNotEmpty) {
        selectedAttributes.addAll({
          firstAttr.name: firstAttrValue,
          lastAttr.name: lastAttrValue,
        });
      }
    }
    updateVariation();
  }

  void updateSelectedAttribute(String attributeName, String value) {
    selectedAttributes[attributeName] = value;
    updateVariation();
  }

  void onAttributeSelected(ProductModel product, String attributeName, dynamic value) {
    this.product = product;
    updateSelectedAttribute(attributeName, value.toString());
  }

  List<String> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName) {
    final availableValues = <String>{};
    for (var variation in variations) {
      final variationValue = variation.attributeValues[attributeName]?.toString().trim();
      if (variationValue != null && variationValue.isNotEmpty) {
        availableValues.add(variationValue);
      }
    }
    return availableValues.toList();
  }

  void updateVariation() {
    final matchingVariation = getMatchingVariation();
    if (matchingVariation != null) {
      displayedPrice.value = matchingVariation.price;
      maxStock.value = matchingVariation.stock;
      displayedStockStatus.value = matchingVariation.stock > 0 ? 'In Stock' : 'Currently Unavailable';
      canIncrease.value = matchingVariation.stock > 0;
      isVariationSelected.value = true;
      selectedVariation.value = matchingVariation;
    } else {
      displayedPrice.value = product.price;
      maxStock.value = 0;
      displayedStockStatus.value = 'Currently Unavailable';
      canIncrease.value = false;
      isVariationSelected.value = false;
      selectedVariation.value = ProductVariationModel.empty();
    }
    update();
  }

  ProductVariationModel? getMatchingVariation() {
    if (selectedAttributes.isEmpty) return null;

    return product.variations.firstWhereOrNull((variation) {
      final variationAttrs = variation.attributeValues;
      return selectedAttributes.entries.every((entry) {
        final attrName = entry.key;
        final attrValue = entry.value.toLowerCase().trim();
        final variationValue = variationAttrs[attrName]?.toLowerCase().trim() ?? '';
        return variationValue == attrValue;
      });
    });
  }

  String getVariationPrice(ProductModel product) {
    final matchingVariation = getMatchingVariation();
    return matchingVariation?.price.toString() ?? product.price.toString();
  }
}