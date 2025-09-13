import 'package:cafe/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CElevatedButtonTheme {
  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(200, 200),
      elevation: 3,
      foregroundColor: Colors.white,
      backgroundColor: CColors.primary,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.green),
      padding: EdgeInsets.symmetric(vertical: 10),
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
