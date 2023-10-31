import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  iconButtonTheme: IconButtonThemeData(),
  iconTheme: IconThemeData(color: Colors.black,),
  appBarTheme: AppBarTheme(backgroundColor: Colors.white,elevation: 0.0),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.red,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStatePropertyAll(BorderSide(color: Colors.red),),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            textStyle: TextStyle(
              fontSize: 12,
            ))));

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
);
