import 'package:adventuresclub/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static String fontName = 'Raleway';
  static ThemeData getCurrentTheme(bool isDark) {
    return ThemeData(
        useMaterial3: true,
        fontFamily: fontName,
        scaffoldBackgroundColor: greyProfileColor);
  }
}