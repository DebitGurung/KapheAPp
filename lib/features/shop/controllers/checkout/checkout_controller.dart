import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/common/widgets/text/section_heading.dart';
import 'package:kapheapp/utils/constants/image_strings.dart';

import '../../../../common/widgets/list_tiles/payment_tile.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Cash on delivery', image: TImages.cod );
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context){

    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TSectionHeading(title: 'Select payment method', showActionButton: false),
              SizedBox(height: TSizes.spaceBtwSections),
              TPaymentTile(paymentMethod: PaymentMethodModel(image: TImages.cod , name: 'Cash on delivery')),
              SizedBox(height: TSizes.spaceBtwItems/2),
              TPaymentTile(paymentMethod: PaymentMethodModel(image: TImages.esewa , name: 'Esewa')),
              SizedBox(height: TSizes.spaceBtwItems/2),
            ],
          ),
        ),
      ),
    );
  }
}
