import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/model/entities/active_plan_model.dart';
import 'package:flutter/material.dart';

class CustomLinearIndicator extends StatelessWidget {
  const CustomLinearIndicator({super.key, required this.activePlanModel});
  final ActivePlanModel activePlanModel;
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: activePlanModel.theCurrentDay / activePlanModel.planDays,
      valueColor: AlwaysStoppedAnimation(AppColors.kRowActionColor),
      backgroundColor: Color(0xffEFE0CD),
      minHeight: 5,
      borderRadius: BorderRadius.circular(16),
    );
  }
}