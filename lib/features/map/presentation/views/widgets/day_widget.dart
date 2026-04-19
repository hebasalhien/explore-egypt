import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/cost_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/plan_step_card.dart';
import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({
    super.key,
    required this.screenHeight,
    required this.trip,
    required this.screenWidth,
  });

  final double screenHeight;
  final TripModel trip;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 16),
        child: Column(
          spacing: 20,
          children: [
            CostWidget(
              screenHeight: screenHeight,
              cost: trip.dayModel[0].totalCost,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PlanStepCard(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  time: trip.dayModel[0].activity[index].time,
                  cost: trip.dayModel[0].activity[index].cost,
                  title: trip.dayModel[0].activity[index].landmarkName,
                  subtitle: trip.dayModel[0].activity[index].description,
                  imageURL: trip.dayModel[0].activity[index].image,
                );
              },
              itemCount: trip.dayModel[0].activity.length,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
