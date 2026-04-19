import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/day_stepper.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/day_widget.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  PlanPage({super.key, required this.screenHeight, required this.screenWidth});

  final trip = TripModel.fromJson(fakeData.fakeTrip);

  // void _onDaySelected(BuildContext context, int index) {
  //   context.read<TripCubit>().selectDay(index);
  //   final offset = (index * 68.0 - 80).clamp(0.0, double.infinity);
  //   _scrollController.animateTo(
  //     offset,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          DayStepper(selectedDay: 0, totalDays: 7,),
        DayWidget(
          screenHeight: screenHeight,
          trip: trip,
          screenWidth: screenWidth,
        ),
      ],
    );
  }
}
