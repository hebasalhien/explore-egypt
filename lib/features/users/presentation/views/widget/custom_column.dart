import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomColumn extends StatelessWidget {
  final String number;
  final String text;
  const CustomColumn({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        Text(
          number,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontSize: 20,
            color: AppColors.kSmallText,
          ),
        ),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontSize: 10),
        ),
      ],
    );
  }
}
