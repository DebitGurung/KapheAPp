import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/success_screen/success_screen.dart';
import 'package:kapheapp/data/repositories/authentication/authentication_repository.dart';
import 'package:kapheapp/features/personalization/controllers/address_controller.dart';
import 'package:kapheapp/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:kapheapp/features/shop/controllers/product/cart_controller.dart';
import 'package:kapheapp/utils/constants/enums.dart';
import 'package:kapheapp/utils/popups/full_screen_loader.dart';
import 'package:kapheapp/utils/popups/loaders.dart';
import '../../../../data/repositories/order/order_repository.dart';
import '../../../../navigation/navigation_menu.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  // Fetch user order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoader.warningSnackBar(title: 'Something went wrong.', message: e.toString());
      return [];
    }
  }

  // Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      // Start loader
      TFullScreenLoader.openLoadingDialog('Processing your order', TImages.processing);

      // Get user authentication id
      final authUser = AuthenticationRepository.instance.authUser;
      if (authUser == null || authUser.uid.isEmpty) {
        TLoader.errorSnackBar(
          title: 'Error',
          message: 'Unable to find user information. Please try again.',
        );
        return;
      }

      // Add details
      final order = OrderModel(
        // Generate unique key
        id: UniqueKey().toString(),
        userId: authUser.uid,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        // Set date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // Save the order to Firestore
      await orderRepository.saveOrder(order, authUser.uid);

      // Update the cart status
      cartController.clearCart();

      // Show success screen
      Get.off(() => Get.offAll(() => SuccessScreen(
        image: TImages.orderSuccess,
        title: 'Drink order has been placed!',
        subTitle: 'Your drink will be delivered.',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      )));
    } catch (e) {
      TLoader.errorSnackBar(title: 'Something went wrong', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}