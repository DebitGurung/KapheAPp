import 'package:flutter/material.dart';

class TElevatedButtonTheme{
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.orange[700],
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.orange),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

    ),
  );
  //ElevatedButtonThemeData is a class that contains the properties of the elevated button theme
  //ElevatedButton is a widget that displays a button with a shadow

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,//color of text
        backgroundColor: Colors.brown[700],//color of button
        disabledForegroundColor: Colors.grey,//color of disabled text
        disabledBackgroundColor: Colors.grey,//color of disabled button
        side: const BorderSide(color: Colors.orange),//border of button
        padding: const EdgeInsets.symmetric(vertical: 18),//padding of button
        textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      )
  );

}