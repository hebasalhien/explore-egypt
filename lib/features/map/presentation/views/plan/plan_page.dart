import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/active_plan.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/cost_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/day_stepper.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/day_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/menu_button.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/no_active_plan.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/no_places_added_yet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanPage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final ValueChanged<int>? onDayChanged;
  final int selectedDay = 0;

  const PlanPage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.onDayChanged,
  });

  @override
  Widget build(BuildContext context) {
    // return trip == null
    //     ? NoActivePlan(screenWidth: screenWidth, screenHeight: screenHeight)
    //     : ActivePlan(
    //         trip: trip,
    //         screenHeight: screenHeight,
    //         screenWidth: screenWidth,
    //         onDayChanged: onDayChanged,
    //       );
    return BlocBuilder<PlanCubit, PlanState>(
      builder: (context, state) {
        if (state is GetActivePlanSuccess) {
          return ActivePlan(
            trip: state.activePlan,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            onDayChanged: onDayChanged,
          );
        } else if (state is PlanLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetActivePlanFailure) {
          return Center(child: Text(state.error));
        } else if (state is NoActivePlan) {
      // ← keep showing NoActivePlanWidget for all these states
      return NoActivePlanWidget(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        plans: state.plans,
      );
    } else {
          return Container();
        }
      },
    );
    // return Column(
    //   children: [
    //     DayStepper(
    //       selectedDay: selectedDay,
    //       totalDays: 1,
    //       onDaySelected: (index) {
    //         // setState(() {
    //         //   selectedDay = index;
    //         // });
    //         // widget.onDayChanged?.call(index);
    //       },
    //     ),
    //     PlanTitle(planTitle: 'new plan'),
    //     CostWidget(screenHeight: screenHeight, cost: '0'),
    //     NoPlacesAddedYet(day: 1),
    //   ],
    // );
  }
}
