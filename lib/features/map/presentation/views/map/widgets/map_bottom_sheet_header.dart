import 'package:explore_egypt/features/map/presentation/views/map/widgets/number_of_locations.dart';
import 'package:flutter/material.dart';

class MapBottomSheetHeader extends StatelessWidget {
  const MapBottomSheetHeader({
    super.key,
    required this.dayNumber,
    required this.planTitle,
    required this.locationsNumber,
  });

  final int dayNumber;
  final String planTitle;
  final int locationsNumber;
  @override
  Widget build(BuildContext context) {
    final shortTitle = planTitle.split(' ').take(2).join(' ');
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xffF3F4F6),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF3F4F6), // Your Figma color (#F3F4F6)
            width: 1.0, // Your Figma stroke weight (1px)
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ), // Spacing top and bottom
            decoration: BoxDecoration(
              color: const Color(
                0xff6B7280,
              ).withValues(alpha: 0.4), // Subtle grey
              borderRadius: BorderRadius.circular(
                2.5,
              ), // Perfectly rounded edges
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: [
                Expanded(
                  child: Text(
                    'Day $dayNumber Plan: $shortTitle ...',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                LocationsNumberContainer(locationsNumber: locationsNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
