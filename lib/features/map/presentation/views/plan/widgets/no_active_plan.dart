import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/custom_gradient_button.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/where_to_start.dart';
import 'package:flutter/material.dart';

class NoActivePlan extends StatelessWidget {
  const NoActivePlan({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 26),
          child: Column(
            spacing: 24,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No active plan yet.",
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.copyWith(fontSize: 28),
              ),
              Text(
                'Let AI curate your perfect\n Egyptian adventure in seconds.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kGrey,
                  fontSize: 18,
                ),
              ),
              CustomGradientButton(screenWidth: screenWidth*.75,title: "Ask AI",icon: Icons.auto_awesome,),
              Divider(
                thickness: 5,
                color: Color(0xffE5E7EB),
                indent: 150,
                endIndent: 150,
                radius: BorderRadius.circular(12),
              ),
              WhereToStart(screenHeight: screenHeight, screenWidth: screenWidth),
            ],
          ),
        ),
      );
  }
}

