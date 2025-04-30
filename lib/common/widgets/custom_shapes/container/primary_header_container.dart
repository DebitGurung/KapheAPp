// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:kapheapp/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:kapheapp/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      // Fixed: Typo corrected
      child: Container(
        color: TColors.primaryColor,
        child: Stack(
          children: [
            // Background Circular Containers
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                backgroundColor: TColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                backgroundColor: TColors.textWhite.withOpacity(0.1),
              ),
            ),
            // Child Content (Search + Categories)
            child,
          ],
        ),
      ),
    );
  }
}
