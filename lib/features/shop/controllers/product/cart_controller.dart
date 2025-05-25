import 'package:get/get.dart';
import 'package:kapheapp/features/shop/models/cart_item_model.dart';
import 'package:kapheapp/features/shop/controllers/product/variation_controller.dart';
import 'package:kapheapp/features/shop/models/product_model.dart';
import 'package:kapheapp/utils/popups/loaders.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  // Getter for total number of items in the cart (sum of quantities)
  RxInt get noOfCartItems => cartItems.fold(0, (sum, item) => sum + item.quantity).obs;

  // Getter for total cart price
  RxDouble get totalCartPrice => cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity)).obs;

  void updateAlreadyAddedProductCount(ProductModel product) {
    final variationController = VariationController.instance;
    final variationId = product.beverageType == 'variable'
        ? variationController.selectedVariation.value.id
        : '';
    productQuantityInCart.value = getProductQuantityInCart(product.id, variationId);
  }

  int getProductQuantityInCart(String productId, String variationId) {
    final cartItem = cartItems.firstWhere(
          (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return cartItem.quantity;
  }

  void updateCart() {
    update();
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    final variationController = VariationController.instance;
    final isVariable = product.beverageType == 'variable';
    final selectedVariationId = isVariable ? variationController.selectedVariation.value.id : '';
    final selectedVariationPrice = isVariable ? double.parse(variationController.getVariationPrice(product)) : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: selectedVariationPrice,
      image: isVariable ? variationController.selectedVariation.value.image : product.thumbnail,
      quantity: quantity,
      variationId: selectedVariationId,
      brand: product.brandId,
      selectedVariation: isVariable
          ? variationController.selectedAttributes.map((key, value) => MapEntry(key, value.toString()))
          : null,
    );
  }

  void addOneToCart(CartItemModel item) {
    final index = cartItems.indexWhere(
          (cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item.copyWith(quantity: 1));
    }
    update();
  }

  void removeOneFromCart(CartItemModel item) {
    final index = cartItems.indexWhere(
          (cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems.removeAt(index);
      }
      update();
    }
  }

  void addToCart(ProductModel product) {
    if (productQuantityInCart.value < 1) {
      TLoader.customToast(message: 'Please select a quantity');
      return;
    }

    final variationController = VariationController.instance;
    final isVariable = product.beverageType == 'variable';
    final selectedVariationId = isVariable ? variationController.selectedVariation.value.id : '';
    final selectedVariationPrice = isVariable ? double.parse(variationController.getVariationPrice(product)) : product.price;

    if (isVariable && selectedVariationId.isEmpty) {
      TLoader.customToast(message: 'Please select a variation (e.g., size or additives)');
      return;
    }

    final cartItem = CartItemModel(
      productId: product.id,
      title: product.title,
      price: selectedVariationPrice,
      image: isVariable ? variationController.selectedVariation.value.image : product.thumbnail,
      quantity: productQuantityInCart.value,
      variationId: selectedVariationId,
      brand: product.brandId,
      selectedVariation: isVariable
          ? variationController.selectedAttributes.map((key, value) => MapEntry(key, value.toString()))
          : null,
    );

    final existingItemIndex = cartItems.indexWhere(
          (item) => item.productId == product.id && item.variationId == selectedVariationId,
    );

    if (existingItemIndex >= 0) {
      cartItems[existingItemIndex].quantity = productQuantityInCart.value;
    } else {
      cartItems.add(cartItem);
    }

    TLoader.successSnackBar(
      title: 'Added to Cart',
      message: '${product.title} has been added to your cart.',
    );

    productQuantityInCart.value = 0; // Reset quantity after adding to cart
    update();
  }

  void clearCart() {
    cartItems.clear();
    productQuantityInCart.value = 0;
    update();
  }
}