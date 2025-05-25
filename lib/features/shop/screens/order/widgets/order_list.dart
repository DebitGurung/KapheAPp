import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/custom_shapes/rounded_container.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../../navigation/navigation_menu.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/order/order_controller.dart';

class TOrderList extends StatelessWidget {
      const TOrderList({super.key});

      @override
      Widget build(BuildContext context) {
            final controller = Get.put(OrderController());
            final dark = THelperFunctions.isDarkMode(context);

            return FutureBuilder(
                future: controller.fetchUserOrders(),
                builder: (_, snapshot) {
                      final emptyWidget = TAnimationLoaderWidget(
                            text: 'Something went wrong',
                            animation: TImages.orderSuccess,
                            showAction: true,
                            actionText: 'Continue to add drinks',
                            onActionPressed: () =>
                                Get.off(() => const NavigationMenu()),
                      );

//helper function : handle loader, no record, or error message
                      final response = TCloudHelperFunctions
                          .checkMultipleRecordState(
                          snapshot: snapshot, nothingFound: emptyWidget);
                      if (response != null) return response;

//congratulations record found
                      final orders = snapshot.data!;
                      return ListView.separated(
                          shrinkWrap: true,
                          itemCount: orders.length,
                          separatorBuilder: (_, index) =>
                          const SizedBox(height: TSizes.spaceBtwItems),
                          itemBuilder:
                              (_, index) {
                                final order = orders[index];
                                return TRoundedContainer(
                                      showBorder: true,
                                      padding: const EdgeInsets.all(TSizes.md),
                                      backgroundColor: dark
                                          ? TColors.black
                                          : TColors.white,
                                      child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                  //Row1
                                                  Row(
                                                        children: [
                                                              //image
                                                              const Icon(Icons
                                                                  .shopping_bag),
                                                              const SizedBox(
                                                                  width: TSizes
                                                                      .spaceBtwItems /
                                                                      2),
                                                              //status and date
                                                              Expanded(
                                                                    child: Column(
                                                                          mainAxisSize: MainAxisSize
                                                                              .min,
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .start,
                                                                          children: [
                                                                                Text(
                                                                                      order
                                                                                          .orderStatusText,
                                                                                      style: Theme
                                                                                          .of(
                                                                                          context)
                                                                                          .textTheme
                                                                                          .bodyLarge!
                                                                                          .apply(
                                                                                            color: TColors
                                                                                                .primaryColor,
                                                                                            fontWeightDelta: 1,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                      order
                                                                                          .formattedOrderDate,
                                                                                      style: Theme
                                                                                          .of(
                                                                                          context)
                                                                                          .textTheme
                                                                                          .headlineSmall,
                                                                                ),
                                                                          ],
                                                                    ),
                                                              ),
                                                              IconButton(
                                                                    onPressed: () {},
                                                                    icon: const Icon(
                                                                          Icons
                                                                              .arrow_circle_right_outlined,
                                                                          size: TSizes
                                                                              .iconSm,
                                                                    ),
                                                              ),
                                                        ],
                                                  ),
                                                  const SizedBox(height: TSizes
                                                      .spaceBtwItems),
                                                  //Row2
                                                  //bottom row
                                                  Row(
                                                        children: [
                                                              Expanded(
                                                                    child: Row(
                                                                          children: [
                                                                                //icon
                                                                                const Icon(
                                                                                    Icons
                                                                                        .attach_file),
                                                                                const SizedBox(
                                                                                    width: TSizes
                                                                                        .spaceBtwItems /
                                                                                        2),
                                                                                //order
                                                                                Expanded(
                                                                                      child: Column(
                                                                                            mainAxisSize: MainAxisSize
                                                                                                .min,
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .start,
                                                                                            children: [
                                                                                                  Text(
                                                                                                        'Order',
                                                                                                        maxLines: 1,
                                                                                                        overflow: TextOverflow
                                                                                                            .ellipsis,
                                                                                                        style: Theme
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .textTheme
                                                                                                            .labelMedium,
                                                                                                  ),
                                                                                                  Text(
                                                                                                        order
                                                                                                            .id,
                                                                                                        maxLines: 1,
                                                                                                        overflow: TextOverflow
                                                                                                            .ellipsis,
                                                                                                        style: Theme
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .textTheme
                                                                                                            .titleMedium,
                                                                                                  ),
                                                                                            ],
                                                                                      ),
                                                                                ),
                                                                          ],
                                                                    ),
                                                              ),
                                                              //row3
                                                              Expanded(
                                                                    child: Row(
                                                                          children: [
                                                                                const Icon(
                                                                                    Icons
                                                                                        .calendar_month),
                                                                                const SizedBox(
                                                                                    width: TSizes
                                                                                        .spaceBtwItems /
                                                                                        2),
                                                                                //status and date
                                                                                Expanded(
                                                                                      child: Column(
                                                                                            mainAxisSize: MainAxisSize
                                                                                                .min,
                                                                                            crossAxisAlignment: CrossAxisAlignment
                                                                                                .start,
                                                                                            children: [
                                                                                                  Text(
                                                                                                        'Order date',
                                                                                                        maxLines: 1,
                                                                                                        overflow: TextOverflow
                                                                                                            .ellipsis,
                                                                                                        style:
                                                                                                        Theme
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .textTheme
                                                                                                            .labelMedium,
                                                                                                  ),
                                                                                                  Text(
                                                                                                        order
                                                                                                            .formattedOrderDate,
                                                                                                        maxLines: 1,
                                                                                                        overflow: TextOverflow
                                                                                                            .ellipsis,
                                                                                                        style: Theme
                                                                                                            .of(
                                                                                                            context)
                                                                                                            .textTheme
                                                                                                            .titleMedium,
                                                                                                  ),
                                                                                            ],
                                                                                      ),
                                                                                ),
                                                                          ],
                                                                    ),
                                                              ),
                                                        ],
                                                  ),
                                            ],
                                      ),
                                );
                          }
                      );
                }
            );
      }
}
