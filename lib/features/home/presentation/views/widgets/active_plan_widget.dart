import 'package:explore_egypt/features/home/model/entities/active_plan_model.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/active_plan_header.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/custom_linear_indecator.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/next_destination_widget.dart';
import 'package:flutter/material.dart';

class ActivePlanWidget extends StatelessWidget {
  const ActivePlanWidget({super.key, required this.activePlanModel});
  final ActivePlanModel activePlanModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFFF2E2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            ActivePlanHeader(activePlanModel: activePlanModel),
            CustomLinearIndicator(activePlanModel: activePlanModel),
            NextDestinationWidget(activePlanModel: activePlanModel),
          ],
        ),
      ),
    );
  }
}
