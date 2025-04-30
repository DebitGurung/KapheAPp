import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/product_attribute.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../product_reviews/widgets/product_review.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        bottomNavigationBar: const TBottomAddToCart(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TProductImageSlider(dark: dark),
              Padding(
                  padding: const EdgeInsets.only(
                      right: TSizes.defaultSpace,
                      left: TSizes.defaultSpace,
                      bottom: TSizes.defaultSpace),
                  child: Column(
                    //rating and share
                    children: [
                      const TRatingAndShare(),
                      //price,title
                      const TProductMetaData(),
                      //attributes()
                      const TProductAttribute(),

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text('Checkout'))),

                      const TSectionHeading(
                        title: 'Description',
                        showActionButton: false,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      const ReadMoreText(
                        'Freshen up your day with our affagato with fine quality beans',
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                        lessStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),

                      const Divider(),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TSectionHeading(
                            title: 'Reviews(199)',
                            showActionButton: false,
                          ),
                          IconButton(
                              onPressed: () =>
                                  Get.to(() => const ProductReviewScreen()),
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
