import 'package:flutter/material.dart';

class TOutLinedButtonTheme{
  TOutLinedButtonTheme._();

  static final lightOutLinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.orange,
    side: const BorderSide(color: Colors.orange),
    textStyle: const TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.w600),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
  );
  //OutlinedButtonThemeData is a class that contains the properties of the outlined button theme
  //OutlinedButton is a widget that displays a button with a border
  static final darkOutLinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.brown,
      side: const BorderSide(color: Colors.brown),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}