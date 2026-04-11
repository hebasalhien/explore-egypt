import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarBackground extends StatelessWidget {
  const AppBarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.kSecondaryVariant, AppColors.kPrimaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(93),
          bottomRight: Radius.circular(93),
        ),
      ),
      height: MediaQuery.of(context).size.height * .25,
    );
  }
}
