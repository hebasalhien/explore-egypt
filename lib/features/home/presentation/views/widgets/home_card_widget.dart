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
      width: screenWidth * .8,
      height: screenHeight * .2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          ExploreWidget(),
          Divider(color: AppColors.kGrey, thickness: .5),
          CustomGradientButton(screenWidth: screenWidth),
        ],
      ),
    );
  }
}

