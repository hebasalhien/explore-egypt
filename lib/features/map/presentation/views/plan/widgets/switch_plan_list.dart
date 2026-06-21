import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/core/widgets/delete_confirmation_dialog.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/switch_plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchPlanList extends StatelessWidget {
  const SwitchPlanList({
    super.key,
    required this.plans,
  });

  final List<TripModel> plans;

  @override
  Widget build(BuildContext context) {
    final planCubit = context.read<PlanCubit>();
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final trip = plans[index];

          return Dismissible(
            // Key must be unique to prevent UI layout recycling bugs
            key: Key(trip.id ?? index.toString()),

            // Constrains swiping direction from left to right only
            direction: DismissDirection.startToEnd,

            // Background revealed behind the card during a swipe
            background: Container(
              margin: const EdgeInsets.only(
                bottom: 12,
              ), // Align precisely with SwitchPlan's bottom padding
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.kSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Delete\n Plan',
                style: TextStyle(color: Colors.white),
              ),
            ),

            // Triggered when swipe target execution threshold completes
confirmDismiss: (direction) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => BlocProvider.value(
      value: planCubit,
      child: DeleteConfirmationDialog(
        title: 'Delete plan',
        content: 'Are you sure you want to delete this plan?',
        onConfirm: () {
          planCubit.deletePlan(tripId: trip.id ?? '');
          Navigator.of(context).pop(true); 
          planCubit.getAllPlans();
        },
      ),
    ),
  );
  return confirmed ?? false; // ← false = snap back ✅
},

            child: SwitchPlan(trip: trip),
          );
        },
      ),
    );
  }
}
