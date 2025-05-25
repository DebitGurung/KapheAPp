import 'package:flutter/material.dart';
import 'package:kapheapp/utils/device/device_utility.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;


  @override
  Widget build(BuildContext context) {
    // Handle empty tabs to prevent RangeError
    if (tabs.isEmpty) {
      return const SizedBox.shrink(); // Return an empty widget if no tabs
    }

    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: TColors.orange,
        unselectedLabelColor: TColors.darkerGrey,
        labelColor: dark ? TColors.white : TColors.primaryColor,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}