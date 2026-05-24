import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TotalPlansNumber extends StatelessWidget {
  const TotalPlansNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffFDF2E9),
      ),
      child: Text(
        '3 PLANS',
        style: TextStyle(
          color: AppColors.kPrimaryColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
