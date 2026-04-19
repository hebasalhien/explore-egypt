import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/day_circle.dart';
import 'package:flutter/material.dart';

class DayStepper extends StatelessWidget {
  final int selectedDay;
  final int totalDays;
  //final ValueChanged<int> onDaySelected;

  const DayStepper({super.key, required this.selectedDay, required this.totalDays,
  // required this.onDaySelected
   });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemBuilder: (_, index) => DayCircle(
          isSelected: index == selectedDay,
          dayNum: index + 1,
          onTap: (){},
        ),
        separatorBuilder: (_, __) => Connector(),
        itemCount: totalDays,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class Connector extends StatelessWidget {
  const Connector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      child: Center(
        child: Container(
          height: 1.5,
          color: AppColors.kPrimaryColor.withAlpha(33),
        ),
      ),
    );
  }
}
