import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/cost_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/day_stepper.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/day_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class ActivePlan extends StatefulWidget {
  const ActivePlan({
    super.key,
    required this.trip,
    required this.screenHeight,
    required this.screenWidth,
  });

  final TripModel? trip;
  final double screenHeight;
  final double screenWidth;

  @override
  State<ActivePlan> createState() => _ActivePlanState();
}

class _ActivePlanState extends State<ActivePlan> {
  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            DayStepper(
              selectedDay: selectedDay,
              totalDays: widget.trip!.days,
              onDaySelected: (index) {
                setState(() {
                  selectedDay = index;
                });
                
              },
            ),
            PlanTitle(planTitle: widget.trip!.title),
            CostWidget(
              screenHeight: widget.screenHeight,
              cost: widget.trip!.dayModel[selectedDay].totalCost.toString(),
            ),
            DayWidget(
              screenHeight: widget.screenHeight,
              trip: widget.trip!,
              screenWidth: widget.screenWidth,
              selectedDay: selectedDay,
            ),
          ],
        ),
        Positioned(bottom: 20, right: 20, child: MenuButton()),
      ],
    );
  }
}
