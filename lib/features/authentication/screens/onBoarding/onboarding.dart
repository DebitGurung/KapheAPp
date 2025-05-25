import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kapheapp/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:kapheapp/features/authentication/screens/onBoarding/widgets/onboarding_dot_navigation.dart';
import 'package:kapheapp/features/authentication/screens/onBoarding/widgets/onboarding_next_button.dart';
import 'package:kapheapp/features/authentication/screens/onBoarding/widgets/onboarding_page.dart';
import 'package:kapheapp/features/authentication/screens/onBoarding/widgets/onboarding_skip.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          //horizontal scrollable pages
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: const [
            OnBoardingPage(
              image: TImages.onBoardingImage1,
              title: TText.onBoardingTitle1,
              subTitle: TText.onBoardingSubTitle1,
            ),
            OnBoardingPage(
              image: TImages.onBoardingImage2,
              title: TText.onBoardingTitle2,
              subTitle: TText.onBoardingSubTitle2,
            ),
            OnBoardingPage(
              image: TImages.onBoardingImage3,
              title: TText.onBoardingTitle3,
              subTitle: TText.onBoardingSubTitle3,
            ),
          ],
        ),
        //skip button
        const OnBoardingSkip(),
        const OnBoardingDotNavigation(),
        const OnBoardingNextButton(),
      ],
    ));
  }
}
