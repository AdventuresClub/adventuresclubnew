import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static String fontName = 'Raleway';
  static ThemeData getCurrentTheme(bool isDark) {
    return ThemeData(
      datePickerTheme: const DatePickerThemeData(),
      useMaterial3: true,
      fontFamily: fontName,
      scaffoldBackgroundColor: greyProfileColor,
      cardTheme: const CardTheme(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
