import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final IconData iconData;

  const MenuItem({super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Icon(iconData, color: AppColors.kPrimaryVariant),
        Text(text, style: TextStyle(color: AppColors.kPrimaryVariant)),
      ],
    );
  }
}
