
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/authentication/screens/login/widgets/login_form.dart';
import 'package:kapheapp/features/authentication/screens/login/widgets/login_header.dart';
import 'package:kapheapp/utils/helpers/helper_functions.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/form_divider.dart';
import '../../../../common/widgets/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    Get.put(LoginController()); // Initialize controller once

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              TLoginHeader(dark: dark),
              const TLoginForm(),
              const TFormDivider(dividerText: ''),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}