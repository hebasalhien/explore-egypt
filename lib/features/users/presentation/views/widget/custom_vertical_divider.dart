import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(color: AppColors.kSecondary, thickness: .5);
  }
}