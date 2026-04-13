import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.chatPage);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.kSecondary, AppColors.kPrimaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          width: screenWidth * .75,
          height: 60,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Icon(Icons.auto_awesome, color: AppColors.kWhite),
              Text('Ask AI', style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}

