import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xfffec260),
      shape: RoundedRectangleBorder(),
    ),
    colorScheme: ColorScheme.dark(
      primary: Color(0xfffec260),
    ).copyWith(secondary: Color(0xfffec260)),
    appBarTheme: AppBarTheme(color: Color(0xfffec260)),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(primary: Color(0xfffec260))
        .copyWith(secondary: Color(0xfffec260)),
    appBarTheme: AppBarTheme(color: Color(0xfffec260)),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xfffec260),
      shape: RoundedRectangleBorder(),
    ),
  );
}
