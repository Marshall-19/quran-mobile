import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appPurpleLight = Color(0xFF9345F2);
const appPurpleStrongLight = Color(0xFFB9A2D8);
const appWhite = Color(0xFFFAF8FC);
const appOrange = Color(0xFFE6704A);
const appDarkTheme = Color(0xFF010313);

ThemeData themeLight = ThemeData(
  fontFamily: 'NotoSans Regular',
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: appPurple),
  brightness: Brightness.light,
  primaryColor: appPurple,
  scaffoldBackgroundColor: appWhite,
  appBarTheme: AppBarTheme(backgroundColor: appPurple),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: appPurpleLight,
    ),
    bodyText2: TextStyle(
      color: appPurpleLight,
    ),
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.grey,
  ),
  
);
ThemeData themeDark = ThemeData(
    fontFamily: 'NotoSans Regular',
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: appPurple),
    brightness: Brightness.dark,
    primaryColor: appPurple,
    scaffoldBackgroundColor: appDarkTheme,
    appBarTheme: AppBarTheme(backgroundColor: appDarkTheme),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: appWhite,
      ),
      bodyText2: TextStyle(
        color: appWhite,
      ),
    ),
    listTileTheme: ListTileThemeData(
      textColor: appWhite,
    ));
