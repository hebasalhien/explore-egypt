import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/model/entities/active_plan_model.dart';
import 'package:flutter/material.dart';

class ActivePlanHeader extends StatelessWidget {
  const ActivePlanHeader({super.key, required this.activePlanModel});
  final ActivePlanModel activePlanModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          activePlanModel.planName.toUpperCase(),
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: AppColors.kTitleMedium),
        ),
        Text(
          'Day ${activePlanModel.theCurrentDay} of ${activePlanModel.planDays}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColors.kTitleMedium,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

