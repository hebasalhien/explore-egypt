import 'package:explore_egypt/features/map/presentation/views/plan/widgets/switch_plan_card.dart';
import 'package:flutter/material.dart';

class SwitchPlanList extends StatelessWidget {
  const SwitchPlanList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 4,
        itemBuilder: (context, index) {
          return SwitchPlan(
            title: 'Essential Egypt',
            days: '4',
            stops: '2',
            imageURL: 'assets/images/pyramid.png',
            isPlanActive: false,
          );
        },
      ),
    );
  }
}

