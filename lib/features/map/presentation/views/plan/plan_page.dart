import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/active_plan.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/no_active_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanPage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final ValueChanged<int>? onDayChanged;
  final int selectedDay;

  const PlanPage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.selectedDay,
    this.onDayChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanCubit, PlanState>(
      buildWhen: (previous, current) =>
          current is PlanLoaded ||
          current is GetActivePlanSuccess ||
          current is GetActivePlanFailure ||
          current is NoActivePlan,
      builder: (context, state) {
        return state is GetActivePlanSuccess
            ? ActivePlan(
                trip: state.activePlan,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                selectedDay: selectedDay,
                onDayChanged: onDayChanged,
              )
            : state is PlanLoaded
            ? ActivePlan(
                trip: state.trip,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                selectedDay: selectedDay,
                onDayChanged: onDayChanged,
              )
            : state is PlanLoading
            ? Center(child: CircularProgressIndicator())
            : state is GetActivePlanFailure
            ? Center(child: Text(state.error))
            : state is NoActivePlan
            ? NoActivePlanWidget(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                plans: state.plans,
              )
            : Container();
      },
    );

  }
}

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