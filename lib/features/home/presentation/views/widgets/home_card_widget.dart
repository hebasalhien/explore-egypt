import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/custom_gradient_button.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/explore_widget.dart';
import 'package:flutter/material.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * .9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 24,
            spreadRadius: 0,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            ExploreWidget(),
            Divider(color: AppColors.kGrey, thickness: .2,indent: 12,endIndent: 12,),
            CustomGradientButton(screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}
