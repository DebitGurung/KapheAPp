import 'package:flutter/material.dart';

class TBottomSheetTheme{
  TBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
   showDragHandle: true,//shows drag handle
    backgroundColor: Colors.white,//background color of bottom sheet
    modalBackgroundColor: Colors.white,//background color of modal
    constraints: const BoxConstraints(minWidth: double.infinity),//width of bottom sheet
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),//shape of bottom sheet
  );
//BottomSheetThemeData is a class that contains the properties of the bottom sheet theme
  //bottomSheet is a widget that displays a bottom sheet
  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.brown,
    modalBackgroundColor: Colors.brown,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}