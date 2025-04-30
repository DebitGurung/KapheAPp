import 'package:flutter/material.dart';

class TChipTheme{
  TChipTheme._();

  static ChipThemeData lightChipTheme = const ChipThemeData(
  disabledColor: Colors.grey,
  selectedColor: Colors.orange,
  labelStyle:  TextStyle(color: Colors.black),
  padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  checkmarkColor: Colors.white,
  );
  //ChipThemeData is a class that contains the properties of the chip theme
  //Chip is a widget that displays a chip
  //compact elements that represent an entity or concept, attribute, text.
  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: Colors.grey,
    selectedColor: Colors.brown,
    labelStyle:  TextStyle(color: Colors.white),
    padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
}