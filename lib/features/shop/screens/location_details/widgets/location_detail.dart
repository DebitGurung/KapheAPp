import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/features/shop/models/cafe_model.dart';
import 'package:kapheapp/features/shop/screens/location_details/widgets/location_attribute.dart';
import 'package:kapheapp/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../location_review/widgets/location_review.dart';
import 'location_detail_image_slider.dart';
import 'location_meta_data.dart';

class LocationDetail extends StatelessWidget {
  const LocationDetail({
    super.key,
  required this.cafe,
  });

  final CafeModel cafe;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: TLocationImageSlider(

                dark: dark, cafe: cafe, // Get dark mode status properly
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  TRatingAndShare(

                  ),
                  TLocationMetaData(
                    cafe: cafe,

                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TLocationAttribute(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
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
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                        title: 'Reviews(199)',
                        showActionButton: false,
                      ),
                      IconButton(
                          onPressed: () => Get.to(() => const LocationReviewScreen()),
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 18,
                          ))
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}