import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/common/widgets/products/rating/user_review_card.dart';
import 'package:kapheapp/features/shop/product_reviews/widgets/rating_progress_indicator.dart';

import '../../../../common/widgets/products/rating/rating_indicator.dart';
import '../../../../utils/constants/sizes.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TAppBar(
          title: Text('Reviews'),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Reviews from customers'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 3.5),
              Text('1,000', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ]),
          ),
        ));
  }
}
