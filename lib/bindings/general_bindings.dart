import 'package:get/get.dart';
import 'package:kapheapp/data/repositories/address/address_repository.dart';
import 'package:kapheapp/data/repositories/banners/banner_repository.dart';
import 'package:kapheapp/data/repositories/brands/brand_repository.dart';
import 'package:kapheapp/data/repositories/cafe/cafe_repository.dart';
import 'package:kapheapp/data/repositories/cafe_categories/cafe_category_repository.dart';
import 'package:kapheapp/data/repositories/categories/category_repository.dart';
import 'package:kapheapp/data/repositories/order/order_repository.dart';
import 'package:kapheapp/data/repositories/user/user_repository.dart';
import 'package:kapheapp/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:kapheapp/features/shop/controllers/order/order_controller.dart';
import 'package:kapheapp/features/shop/controllers/product/cart_controller.dart';
import 'package:kapheapp/features/shop/controllers/product/variation_controller.dart';
import 'package:kapheapp/network_manager/network_manager.dart';

import '../data/repositories/authentication/authentication_repository.dart';
import '../data/repositories/products/product_repository.dart';
import '../features/authentication/controllers/forget_password/forget_password_controller.dart';
import '../features/authentication/controllers/login/login_controller.dart';
import '../features/authentication/controllers/onboarding/onboarding_controller.dart';
import '../features/authentication/controllers/signup/signup_controller.dart';
import '../features/authentication/controllers/signup/verify_email_controller.dart';
import '../features/personalization/controllers/address_controller.dart';
import '../features/personalization/controllers/update_name_controller.dart';
import '../features/personalization/controllers/user_controller.dart';
import '../features/shop/controllers/all_product/all_product_controller.dart';
import '../features/shop/controllers/banner/banner_controller.dart';
import '../features/shop/controllers/brand/brand_controller.dart';
import '../features/shop/controllers/cafe_location/cafe_category_controller.dart';
import '../features/shop/controllers/cafe_location/cafe_controller.dart';
import '../features/shop/controllers/cafe_location/location_image_controller.dart';
import '../features/shop/controllers/favourite_icon/favourite_controller.dart';
import '../features/shop/controllers/home/home_controller.dart';
import '../features/shop/controllers/product/category_controller.dart';
import '../features/shop/controllers/product/images_controller.dart';
import '../navigation/navigation_menu.dart';
class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // Repositories
    Get.put(AuthenticationRepository());
    Get.put(ProductRepository());
    Get.put(AddressRepository());
    Get.put(BannerRepository());
    Get.put(BrandRepository());
    Get.put(CafeRepository());
    Get.put(CafeCategoryRepository());
    Get.put(CategoryRepository());
    Get.put(OrderRepository());
    Get.put(UserRepository());

    // Network manager
    Get.put(NetworkManager());

    // Controllers
    Get.put(NavigationController()); // Add NavigationController
    Get.put(VariationController());
    Get.put(CartController());
    Get.put(AllProductsController());
    Get.put(BannerController());
    Get.put(CafeCategoryController());
    Get.put(CafeController());
    Get.put(LocationImageController());
    Get.put(FavouritesController());
    Get.put(HomeController());
    Get.put(CategoryController());
    Get.put(ImageController());
    Get.put(BrandController());
    Get.put(ForgetPasswordController());
    Get.put(LoginController());
    Get.put(OnBoardingController());
    Get.put(SignupController());
    Get.put(VerifyEmailController());
    Get.put(AddressController());
    Get.put(UpdateNameController());
    Get.put(UserController());
    Get.put(CheckoutController());
    Get.put(OrderController());
    Get.put(VariationController());


  }
}