import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static String fontName = 'Raleway';
  static String arabicFontName = 'Noto Sans Arabic';

  static ThemeData getCurrentTheme(bool isDark) {
    return ThemeData(
      datePickerTheme: const DatePickerThemeData(),
      useMaterial3: true,
      fontFamily: Constants.language == "en" ? fontName : arabicFontName,
      scaffoldBackgroundColor: greyProfileColor,
      cardTheme: const CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
