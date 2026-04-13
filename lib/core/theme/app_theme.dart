import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.kSmallText,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.kBlack,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.kBlack,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.kWhite,
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.kWhite,
      ),
      titleMedium: TextStyle(
        fontFamily: GoogleFonts.notoSerif().fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 24,
        color: AppColors.kTitleMedium,
      ),
      titleSmall: TextStyle(
        fontFamily: GoogleFonts.manrope().fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: AppColors.subtitleColor,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ),
    ),
  );
}
