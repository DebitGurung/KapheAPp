import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/features/shop/screens/location_details/widgets/location_attribute.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../location_review/widgets/location_review.dart';
import 'bottom_add_to_visit_widget.dart';
import 'location_detail_image_slider.dart';
import 'location_meta_data.dart';

class LocationDetail extends StatelessWidget {
  const LocationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        bottomNavigationBar: const TBottomAddToVisit(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TLocationImageSlider(dark: dark),
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
                      const TLocationMetaData(),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      //attributes()
                      const TLocationAttribute(),

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      const TSectionHeading(
                        title: 'Description',
                        showActionButton: false,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      const ReadMoreText(
                        'Visit us and relax with peaceful ambiance and delicious coffee',
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
                                  Get.to(() => const LocationReviewScreen()),
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
