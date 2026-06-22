import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/cost_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/day_stepper.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/day_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivePlan extends StatefulWidget {
  const ActivePlan({
    super.key,
    required this.trip,
    required this.screenHeight,
    required this.screenWidth,
    required this.selectedDay,
    this.onDayChanged,
  });

  final TripModel? trip;
  final double screenHeight;
  final double screenWidth;
  final int selectedDay;
  final ValueChanged<int>? onDayChanged;

  @override
  State<ActivePlan> createState() => _ActivePlanState();
}

class _ActivePlanState extends State<ActivePlan> {
  late int selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = widget.selectedDay;
  }

  @override
  void didUpdateWidget(covariant ActivePlan oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDay != widget.selectedDay) {
      selectedDay = widget.selectedDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanCubit, PlanState>(
      buildWhen: (previous, current) =>
          current is AddNewDaySuccess ||
          current is PlanError ||
          current is GetActivePlanSuccess ||
          current is PlanLoaded,
      builder: (context, state) {
        TripModel trip = widget.trip!;
        if (state is AddNewDaySuccess) {
          trip = state.trip;
        } else if (state is PlanLoaded) {
          trip = state.trip;
        } else if (state is GetActivePlanSuccess) {
          trip = state.activePlan;
        }

        return Stack(
          children: [
            Column(
              children: [
                DayStepper(
                  selectedDay: selectedDay,
                  totalDays: trip.days,
                  onDaySelected: (index) {
                    setState(() {
                      selectedDay = index;
                    });
                    widget.onDayChanged?.call(index);
                  },
                  onTap: () {
                    context.read<PlanCubit>().addNewDayToPlan(
                      trip: trip,
                    );
                  },
                ),
                PlanTitle(trip: trip),
                CostWidget(
                  screenHeight: widget.screenHeight,
                  cost: trip.dayModel[selectedDay].totalCost.toString(),
                ),
                DayWidget(
                  screenHeight: widget.screenHeight,
                  trip: trip,
                  screenWidth: widget.screenWidth,
                  selectedDay: selectedDay,
                ),
              ],
            ),
            Positioned(bottom: 20, right: 20, child: MenuButton()),
          ],
        );
      },
    );
  }
}
