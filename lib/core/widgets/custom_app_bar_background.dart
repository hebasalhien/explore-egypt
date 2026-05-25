import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarBackground extends StatelessWidget {
  final List<Color>? colors;
  final double? r1;
  final Widget? child;
  const AppBarBackground({super.key, this.colors, this.r1, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors == null
              ? [AppColors.kSecondaryVariant, AppColors.kPrimaryColor]
              : colors!,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 1.0],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(r1 == null ? 93 : r1!),
          bottomRight: Radius.circular(r1 == null ? 93 : r1!),
        ),
      ),
      height: MediaQuery.of(context).size.height * .25,
      child: child,
    );
  }
}
