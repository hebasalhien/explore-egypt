import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  const CostWidget({super.key, required this.screenHeight, required this.cost});
  final String cost;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        height: screenHeight * .06,
        decoration: BoxDecoration(
          color: AppColors.kBGColor,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: const Color(0x339E9E9E)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.kBlack),
              ),
              Text(
                '$cost\$',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.kBlack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
