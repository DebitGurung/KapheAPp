import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kapheapp/bindings/general_bindings.dart';
import 'package:kapheapp/routes/app_routes.dart';
import 'package:kapheapp/utils/constants/colors.dart';
import 'package:kapheapp/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      //default theme light theme
      darkTheme: TAppTheme.darkTheme,
      //Show loader or circular progress indicator
      //meanwhile authentication repository shows relevant screen

      initialBinding: GeneralBindings(),

      getPages: AppRoutes.pages,
      home: const Scaffold(
        backgroundColor: TColors.white,
        body: Center(child: CircularProgressIndicator(color: Colors.orange)),
      ),
    );
  }
}
