import 'package:cafe/utils/theme/custom_theme/elevated_button_theme.dart';
import 'package:cafe/utils/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

class CAppTheme {
  static ThemeData cThemeData = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    elevatedButtonTheme: CElevatedButtonTheme.elevatedButtonTheme,
    textTheme: CTextTheme.textTheme
  );
}