import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPlansNumber extends StatelessWidget {
  const TotalPlansNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanCubit, PlanState>(
      builder: (context, state) {
        final String label = switch (state) {
          GetAllPlansLoading() => '...',
          GetAllPlansSuccess(plans: final plans) =>
            '${plans.length} ${plans.length == 1 ? 'PLAN' : 'PLANS'}',
          _ => '',
        };

        if (label.isEmpty) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xffFDF2E9),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
