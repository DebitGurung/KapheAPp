import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';


class TLocationCounterIcon extends StatelessWidget {
  const TLocationCounterIcon({
    super.key,
    required this.onPress,
    this.iconColor,

  });

  final VoidCallback onPress;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: onPress,
            icon: Icon(
              Icons.map,
              color: iconColor,
            )),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: TColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text('',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(
                    color: TColors.white,
                    fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}
