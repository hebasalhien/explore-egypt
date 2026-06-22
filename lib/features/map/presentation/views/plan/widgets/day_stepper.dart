import 'package:explore_egypt/features/map/presentation/views/plan/cubit/plan_cubit.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/add_day_circle.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/day_circle.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/rps_custom_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayStepper extends StatelessWidget {
  final int selectedDay;
  final int totalDays;
  final VoidCallback onTap;
  final ValueChanged<int> onDaySelected;

  const DayStepper({
    super.key,
    required this.selectedDay,
    required this.totalDays,
    required this.onDaySelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: RPSCustomPainter())),
          ListView.builder(
            itemBuilder: (_, index) {
              if (index == totalDays) {
                return Center(
                  child: AddDayCircle(
                    onTap: onTap,
                  ),
                );
              }
              return Center(
                child: DayCircle(
                  isSelected: index == selectedDay,
                  dayNum: index + 1,
                  onTap: () => onDaySelected(index),
                ),
              );
            },
            itemCount: totalDays + 1,
            scrollDirection: Axis.horizontal,
          ),
        ],
      ),
    );
  }
}
