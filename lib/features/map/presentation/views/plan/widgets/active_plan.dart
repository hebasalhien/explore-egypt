import 'package:explore_egypt/core/theme/app_colors.dart';
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
          current is PlanLoaded ||
          current is DeleteModeToggled,
      builder: (context, state) {
        final planCubit = context.read<PlanCubit>();
        final isDeleteMode = planCubit.isDeleteMode;

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
                  onDaySelected: isDeleteMode
                      ? (_) {}
                      : (index) {
                          setState(() {
                            selectedDay = index;
                          });
                          widget.onDayChanged?.call(index);
                        },
                  onTap: isDeleteMode
                      ? () {}
                      : () {
                          context.read<PlanCubit>().addNewDayToPlan(trip: trip);
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
            if (trip.dayModel[selectedDay].activity.isNotEmpty && !isDeleteMode)
              Positioned(
                bottom: 20,
                right: 20,
                child: MenuButton(dayNumber: selectedDay, planId: trip.id),
              ),
            if (isDeleteMode)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Color(0xffFEF8F1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<PlanCubit>().toggleDeleteMode();
                        },

                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.4,
                            40,
                          ),
                          backgroundColor: Color(0xffFEF8F1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: AppColors.kErrorColor,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: AppColors.kErrorColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<PlanCubit>().deletePlaceFromDay(
                            day: selectedDay,
                            planId: trip.id,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.4,
                            40,
                          ),
                          backgroundColor: AppColors.kErrorColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Delete Selected',
                          style: TextStyle(color: AppColors.kWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
