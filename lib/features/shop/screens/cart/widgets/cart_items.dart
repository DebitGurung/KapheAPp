import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kapheapp/features/shop/controllers/product/cart_controller.dart';

import '../../../../../common/widgets/product_price/product_price_text.dart';
import '../../../../../common/widgets/products/product_cart/add_remove_button.dart';
import '../../../../../common/widgets/products/product_cart/cart_item.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
     this.showAddRemoveButton =true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        itemBuilder: (_, index) => Obx(
          ()  {
            final item = cartController.cartItems[index];
            return Column(
              children: [
                //cart item
                 TCartItem(cartItem: item,),
                if (showAddRemoveButton)
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                if (showAddRemoveButton)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 70,
                          ),
                          //add remove button
                          TProductQuantityWithAddRemoveButton(quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item)),
                        ],
                      ),
                      //total price
                       TProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1)),
                    ],
                  ),
              ],
            );
          }
        ),
      ),
    );
  }
}
