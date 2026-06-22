import 'package:explore_egypt/features/map/model/entities/activity_model.dart';
import 'package:explore_egypt/features/map/presentation/views/map/widgets/locations_list_view.dart';
import 'package:explore_egypt/features/map/presentation/views/map/widgets/map_bottom_sheet_header.dart';
import 'package:flutter/material.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({
    super.key,
    required this.dayNumber,
    required this.planTitle,
    required this.activityModel,
    required this.selectedIndex,
    required this.onCardSelected,
  });
  final int dayNumber;
  final String planTitle;
  final List<ActivityModel> activityModel;
  final int? selectedIndex;
  final ValueChanged<int> onCardSelected;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .35,
      minChildSize: 0.2,
      maxChildSize: .5,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Colors.white.withValues(alpha: 0.8),
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController, // 👈 THIS IS THE MAGIC GLUE
              child: MapBottomSheetHeader(
                dayNumber: dayNumber,
                planTitle: planTitle,
                locationsNumber: activityModel.length,
              ),
            ),
            LocationsListView(
              selectedIndex: selectedIndex,
              scrollController: scrollController,
              activityModel: activityModel,
              onCardSelected: onCardSelected,
            ),
          ],
        ),
      ),
    );
  }
}
