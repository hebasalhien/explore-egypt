import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle{
  AppTextStyle._();

  static const TextStyle heading1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.kPrimaryColor,
  );

    static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.kPrimaryColor,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.kGrey,
  );
}