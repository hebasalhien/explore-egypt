import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.kWhite,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.kPrimaryColor,
      indicatorColor: Colors.transparent,
      overlayColor: WidgetStateColor.transparent,
      labelTextStyle: WidgetStateTextStyle.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.kWhite,
              )
            : const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.kBlack,
              ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.kPrimaryColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.kWhite,
      ),
    ),
  );
}
