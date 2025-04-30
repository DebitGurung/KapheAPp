import 'package:flutter/material.dart';

class TCafeLocationText extends StatelessWidget {
  const TCafeLocationText({
    super.key,
    required this.icon,
    required this.location,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });

  final String location;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: isLarge ? 24 : 20),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            location, // Use 'location' directly as the data parameter
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: isLarge
                ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration:
              lineThrough ? TextDecoration.lineThrough : null,
            )
                : Theme.of(context).textTheme.titleLarge!.apply(
              decoration:
              lineThrough ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ],
    );
  }
}