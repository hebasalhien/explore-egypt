import 'package:explore_egypt/features/map/presentation/views/widgets/add_day_circle.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/day_circle.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/rps_custom_painter.dart';
import 'package:flutter/material.dart';

class DayStepper extends StatelessWidget {
  final int selectedDay;
  final int totalDays;
  final ValueChanged<int> onDaySelected;

  const DayStepper({
    super.key,
    required this.selectedDay,
    required this.totalDays,
    required this.onDaySelected,
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
                return AddDayCircle(onTap: () {});
              }
              return DayCircle(
                isSelected: index == selectedDay,
                dayNum: index + 1,
                onTap: () => onDaySelected(index),
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
