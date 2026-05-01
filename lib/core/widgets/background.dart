import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor,
                AppColors.kPrimaryVariant,
                AppColors.kSecondary,
              ],
              begin: Alignment(-0.678, -0.734),
              end: Alignment(0.678, 0.734),
              stops: [0.1133, 0.4191, 0.7305],
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
        ),
        Container(
          height: MediaQuery.of(context).size.height * .3,

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor,
                AppColors.kPrimaryVariant,
                AppColors.kSecondary,
              ],
              begin: Alignment(0.494, -0.869),
              end: Alignment(-0.494, 0.869),
              stops: [0.0132, 0.2734, 0.8428],
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
        ),
      ],
    );
  }
}
