import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kPrimaryColor,
            AppColors.kPrimaryVariant,
            AppColors.kSecondary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Opacity(
        opacity: 0.2,
        child: Image.asset(
          AppConstants.bgImage,
          fit: BoxFit.fill,
          colorBlendMode: BlendMode.multiply,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
