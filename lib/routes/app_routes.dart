import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:kapheapp/features/authentication/screens/forget_password/forgot_password.dart';
import 'package:kapheapp/features/authentication/screens/login/login.dart';
import 'package:kapheapp/features/authentication/screens/onBoarding/onboarding.dart';
import 'package:kapheapp/features/authentication/screens/signup/signup.dart';
import 'package:kapheapp/features/authentication/screens/signup/verify_email.dart';
import 'package:kapheapp/features/personalization/screens/address/address.dart';
import 'package:kapheapp/features/personalization/screens/profile/profile.dart';
import 'package:kapheapp/features/personalization/screens/settings/settings.dart';
import 'package:kapheapp/features/shop/product_reviews/widgets/product_review.dart';
import 'package:kapheapp/features/shop/screens/cart/cart.dart';
import 'package:kapheapp/features/shop/screens/checkout/checkout.dart';
import 'package:kapheapp/features/shop/screens/order/order.dart';
import 'package:kapheapp/features/shop/screens/store/store.dart';
import 'package:kapheapp/features/shop/screens/wishlist/wishlist.dart';
import 'package:kapheapp/routes/routes.dart';

import '../features/shop/screens/home/widgets/home.dart';

class AppRoutes{
  static final pages = [
    GetPage(name: TRoutes.home,page: () => const HomeScreen()),
    GetPage(name: TRoutes.store,page: () => const StoreScreen()),
    GetPage(name: TRoutes.favourites,page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.settings,page: () => const SettingsScreen()),
    GetPage(name: TRoutes.productReviews,page: () => const ProductReviewScreen()),
    GetPage(name: TRoutes.order,page: () => const OrderScreen()),
    GetPage(name: TRoutes.checkout,page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.cart,page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile,page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress,page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signUp,page: () => const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail,page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn,page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword,page: () => const ForgetPassword()),
    GetPage(name: TRoutes.onBoarding,page: () => const OnBoardingScreen()),

  ];
}