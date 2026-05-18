import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/day_stepper.dart';
import 'package:explore_egypt/features/map/presentation/views/widgets/day_widget.dart';
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
        ? Center(child: Text('No plan found'))
        : ActivePlan(
            trip: trip,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          );
  }
}

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
            DayWidget(
              screenHeight: widget.screenHeight,
              trip: widget.trip!,
              screenWidth: widget.screenWidth,
              selectedDay: selectedDay,
            ),
          ],
        ),
        Positioned(bottom: 20, right: 20, child: CustomBottomSheet()),
      ],
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Item $index'));
                },
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.kPrimaryColor,
          boxShadow: [BoxShadow(color: AppColors.kShadowColor, blurRadius: 20)],
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, size: 20, color: Colors.white),
      ),
    );
  }
}
