import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 50,
      children: [
        SizedBox(width: 30),
        Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.kWhite,
          ),
          textAlign: TextAlign.center,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings_outlined, color: AppColors.kWhite),
        ),
      ],
    );
  }
}
