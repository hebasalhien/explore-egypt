import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/cost_widget.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/plan_step_card.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/total_plans_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({
    super.key,
    required this.screenHeight,
    required this.trip,
    required this.screenWidth,
    required this.selectedDay,
  });

  final double screenHeight;
  final TripModel trip;
  final double screenWidth;
  final int selectedDay;

  @override
  Widget build(BuildContext context) {
    if (selectedDay >= trip.dayModel.length) {
      return const Expanded(
        child: Center(
          child: Text('No data available for this day'),
        ),
      );
    }
    

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 16),
        child: Column(
          spacing: 20,
          children: [
            PlanTitle(planTitle: trip.title,),
            CostWidget(
              screenHeight: screenHeight,
              cost: trip.dayModel[selectedDay].totalCost.toString(),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PlanStepCard(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  time: trip.dayModel[selectedDay].activity[index].time,
                  cost: trip.dayModel[selectedDay].activity[index].cost.toString(),
                  title: trip.dayModel[selectedDay].activity[index].landmarkName,
                  subtitle: trip.dayModel[selectedDay].activity[index].description,
                  imageURL: trip.dayModel[selectedDay].activity[index].image,
                );
              },
              itemCount: trip.dayModel[selectedDay].activity.length,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}

class PlanTitle extends StatelessWidget {
  final String planTitle;
  const PlanTitle({
    super.key, required this.planTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          minWidth: MediaQuery.of(context).size.width * 0.5,
        ),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFFF3E9D9), width: 0.81),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000), // #0000000D → ARGB = 0D000000
              offset: Offset(0, 0.81),
              blurRadius: 1.62,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 5,
          children: [
            Icon(Icons.map_outlined),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                planTitle,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.kBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              CupertinoIcons.chevron_down,
              size: 16,
              fontWeight: FontWeight.bold,
            ),
            TotalPlansNumber(),
          ],
        ),
      ),
    );
  }
}
