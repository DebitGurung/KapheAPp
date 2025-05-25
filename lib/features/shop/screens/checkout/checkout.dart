import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/features/shop/controllers/product/cart_controller.dart';
import 'package:kapheapp/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:kapheapp/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:kapheapp/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:kapheapp/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/helpers/price_calculator.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/product_cart/coupon_widget.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/loaders.dart';
import '../../controllers/order/order_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;

    final orderController = Get.put(OrderController());
    final totalAmount = TPriceCalculator.calculateTotalPrice(subTotal, 'Pokhara');
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: Text('Order review',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TCartItems(showAddRemoveButton: false),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TCouponCode(dark: dark),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TRoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: dark ? TColors.black : TColors.white,
                  child: const Column(
                    children: [
                      //pricing
                      TBillingAmountSection(),
                      Divider(),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TBillingPaymentSection(),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Divider(),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      TBillingAddressSection(),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subTotal > 0 ?
            () => orderController.processOrder(totalAmount) 
            : () => TLoader.warningSnackBar(title: 'Empty cart', message: 'Add drinks in the cart to continue.'),
            child:  Text('Checkout Rs$totalAmount')),
      ),
    );
  }
}
