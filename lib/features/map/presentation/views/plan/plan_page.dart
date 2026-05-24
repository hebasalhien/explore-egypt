import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/active_plan.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/no_active_plan.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final TripModel? trip;
  const PlanPage({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return trip == null
        ? NoActivePlan(screenWidth: screenWidth, screenHeight: screenHeight)
        : ActivePlan(
            trip: trip,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          );
  }
}

