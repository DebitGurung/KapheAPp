import 'package:flutter/material.dart';
import 'package:kapheapp/common/widgets/appbar/appbar.dart';
import 'package:kapheapp/utils/constants/sizes.dart';

import '../../../common/widgets/cafes/sortable/sortable_cafe.dart';

class AllCafe extends StatelessWidget {
  const AllCafe({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Popular cafe'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: TSortableCafe(),
        ),
      ),
    );
  }
}
