import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/model/entities/trip_model.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/switch_plan_card.dart';
import 'package:flutter/material.dart';

class SwitchPlanList extends StatelessWidget {
  const SwitchPlanList({
    super.key,
    required this.plans,
    required this.onPlanDismissed, // Added callback to update state/database
  });

  final List<TripModel> plans;
  final Function() onPlanDismissed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final trip = plans[index];

          return Dismissible(
            // Key must be unique to prevent UI layout recycling bugs
            key: Key(trip.id ?? index.toString()), 
            
            // Constrains swiping direction from left to right only
            direction: DismissDirection.startToEnd, 
            
            // Background revealed behind the card during a swipe
            background: Container(
              margin: const EdgeInsets.only(bottom: 12), // Align precisely with SwitchPlan's bottom padding
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.kSecondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('Delete\n Plan',style: TextStyle(color: Colors.white),),
            ),
            
            // Triggered when swipe target execution threshold completes
            confirmDismiss: (direction) {
              if(direction==DismissDirection.startToEnd){
                onPlanDismissed();
              }
              return Future.value(true);
            },
            
            child: SwitchPlan(trip: trip),
          );
        },
      ),
    );
  }
}