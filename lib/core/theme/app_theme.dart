import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/custom_tab_indicator.dart';
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

    tabBarTheme: TabBarThemeData(
      indicator: CustomTabIndicator(),
      unselectedLabelColor: AppColors.kPlanPageBgColor,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: AppColors.kPlanPageBgColor,
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
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.kPrimaryColor,
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
        fontFamily: GoogleFonts.manrope(fontWeight: FontWeight.bold).fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
        color: AppColors.subtitleColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: GoogleFonts.playfair().fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xff111827),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.kPlanPageBgColor,
      )
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.kPrimaryVariant, width: 0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.kErrorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.kErrorColor),
      ),
      hintStyle: TextStyle(
        fontSize: 16,
        color: AppColors.kGrey,
        fontWeight: FontWeight.w500,
      ),
      suffixIconColor: AppColors.kPrimaryColor,
      prefixIconColor: AppColors.kPrimaryColor,
      fillColor: AppColors.kWhite,
      filled: true,
      hintMaxLines: 1,
    ),
  );
}
