import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.text),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.secondary,
  );
}
