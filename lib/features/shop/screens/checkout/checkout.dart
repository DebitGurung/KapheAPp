import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/common/widgets/success_screen/success_screen.dart';
import 'package:kapheapp/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:kapheapp/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:kapheapp/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:kapheapp/navigation/navigation_menu.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/product_cart/coupon_widget.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(
                  () => SuccessScreen(
                    image: TImages.staticSuccessIllustration,
                    title: 'Payment successful',
                    subTitle: 'Your drink will be delivered to you',
                    onPressed: () => Get.to(() => const NavigationMenu()),
                  ),
                ),
            child: const Text('Checkout Rs 500')),
      ),
    );
  }
}
