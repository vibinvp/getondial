import 'package:flutter/material.dart';

class AppTheme{
static Color lightColor = const Color(0xFF039D55);
  static ThemeData lightTheme= ThemeData(
  fontFamily: 'Roboto',
  primaryColor: lightColor,
  secondaryHeaderColor: const Color(0xFF1ED7AA),
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: lightColor)),
  colorScheme: ColorScheme.light(primary: lightColor, secondary: lightColor).copyWith(background: const Color(0xFFF3F3F3)).copyWith(error: const Color(0xFFE84D4F)),
);

static Color darkColor = const Color(0xFF54b46b);
  static ThemeData darkTheme= ThemeData(
  fontFamily: 'Roboto',
  primaryColor: darkColor,
  secondaryHeaderColor: const Color(0xFF009f67),
  disabledColor: const Color(0xffa2a7ad),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: Colors.black,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: darkColor)), colorScheme: ColorScheme.dark(primary: darkColor, secondary: darkColor).copyWith(background: const Color(0xFF343636)).copyWith(error: const Color(0xFFdd3135)),
);
}