import 'package:flutter/material.dart';
import 'package:lending_app/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 3));

  static final darkThemeMode = ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppPallete.backgroundColor),
      appBarTheme:
          const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: _border(),
          focusedBorder: _border(AppPallete.gradient2)));
}
