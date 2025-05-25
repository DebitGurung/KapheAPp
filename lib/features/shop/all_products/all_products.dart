import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/common/widgets/products/product_sortable/sortable_products.dart';
import 'package:kapheapp/utils/constants/sizes.dart';
import 'package:kapheapp/utils/effect/vertical_product_shimmer.dart';
import 'package:kapheapp/utils/helpers/cloud_helper_functions.dart';

import '../controllers/all_product/all_product_controller.dart';
import '../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product fetching
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder<List<ProductModel>>(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              // Check the state of the FutureBuilder snapshot
              const loader = TVerticalProductShimmer();
              final widget = TCloudHelperFunctions.checkMultipleRecordState(
                snapshot: snapshot,
                loader: loader,
              );

              // Return the appropriate widget based on the snapshot state
              if (widget != null) return widget;

              // If no widget is returned, data is available
              final products = snapshot.data!;
              return TSortableProduct(products: products);
            },
          ),
        ),
      ),
    );
  }
}