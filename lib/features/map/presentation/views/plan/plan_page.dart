import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/active_plan.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/cost_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/day_stepper.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/day_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/menu_button.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/no_active_plan.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/no_places_added_yet.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final TripModel? trip;
  final ValueChanged<int>? onDayChanged;
  final int selectedDay = 0;

  const PlanPage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.trip,
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
    return Column(
      children: [
        DayStepper(
          selectedDay: selectedDay,
          totalDays: 1,
          onDaySelected: (index) {
            // setState(() {
            //   selectedDay = index;
            // });
            // widget.onDayChanged?.call(index);
          },
        ),
        PlanTitle(planTitle: 'new plan'),
        CostWidget(screenHeight: screenHeight, cost: '0'),
        NoPlacesAddedYet(day: 1),
      ],
    );
  }
}
