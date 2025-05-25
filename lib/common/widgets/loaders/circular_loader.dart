import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TCircularLoader extends StatelessWidget {
  const TCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(
        radius: 20.0, // Adjust size as needed
        color: Colors.orange, // Customize color to match app theme
      ),
    );
  }
}