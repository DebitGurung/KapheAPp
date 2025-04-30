import 'package:flutter/material.dart';

class TAppBarTheme{
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,//elevation of appbar
    centerTitle: false,//title placement
    scrolledUnderElevation: 0,//elevation of appbar when scrolled
    backgroundColor: Colors.transparent,//
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.orange,size: 24),
    actionsIconTheme: IconThemeData(color: Colors.orange,size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.orange),
  );

  //AppBarTheme is a class that contains the properties of the app bar theme
  //AppBar is a widget that displays a top bar with a title and actions
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.brown,size: 24),
    actionsIconTheme: IconThemeData(color: Colors.brown,size: 24),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.brown),
  );
}