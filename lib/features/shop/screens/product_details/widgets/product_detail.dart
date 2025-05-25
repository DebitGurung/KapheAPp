import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/features/shop/controllers/product/cart_controller.dart';
import 'package:kapheapp/features/shop/controllers/product/variation_controller.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/product_attribute.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';
import '../../../product_reviews/widgets/product_review.dart';
import '../../checkout/checkout.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});

  final ProductModel product;

  @override
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  late final CartController cartController;
  late final VariationController variationController;

  @override
  void initState() {
    super.initState();
    cartController = CartController.instance;
    variationController = VariationController.instance;
    // Removed print statement
    if (widget.product.beverageType == 'variable') {
      variationController.loadVariations(widget.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: widget.product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TProductImageSlider(
              dark: dark,
              product: widget.product,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  const TRatingAndShare(),
                  TProductMetaData(product: widget.product),
                  if (widget.product.beverageType == 'variable')
                    TProductAttribute(product: widget.product),
                  if (widget.product.beverageType == 'variable')
                    const SizedBox(height: TSizes.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: cartController.productQuantityInCart.value > 0
                          ? () {
                        cartController.addToCart(widget.product);
                        Get.to(() => const CheckoutScreen());
                      }
                          : null,
                      child: const Text('Checkout'),
                    ),
                  ),
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    widget.product.description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                        title: 'Reviews(199)',
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => const ProductReviewScreen()),
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}