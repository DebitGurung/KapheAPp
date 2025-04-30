import 'package:flutter/material.dart';
import 'package:kapheapp/utils/theme/customTheme/chip_theme.dart';

import 'customTheme/app_bar_theme.dart';
import 'customTheme/bottom_sheet_theme.dart';
import 'customTheme/checkbox_theme.dart';
import 'customTheme/elevated_theme.dart';
import 'customTheme/outline_button_theme.dart';
import 'customTheme/text_field_theme.dart';
import 'customTheme/text_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'AlumniSansPinstripe',
    brightness: Brightness.light,
    primaryColor: Colors.orange[700],
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutLinedButtonTheme.lightOutLinedButtonTheme,
    inputDecorationTheme: TTextFIeldTHeme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'AlumniSansPinstripe',
    brightness: Brightness.dark,
    primaryColor: Colors.brown[700],
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutLinedButtonTheme.darkOutLinedButtonTheme,
    inputDecorationTheme: TTextFIeldTHeme.darkInputDecorationTheme,
  );
}
