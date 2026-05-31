import 'package:explore_egypt/features/map/model/entities/activity_model.dart';
import 'package:explore_egypt/features/map/presentation/views/map/widgets/place_card.dart';
import 'package:flutter/material.dart';

class LocationsListView extends StatelessWidget {
  const LocationsListView({
    super.key,
    required this.isCardSelected,
    required this.scrollController, required this.activityModel,
  });

  final bool isCardSelected;
  final ScrollController scrollController;
  final List<ActivityModel> activityModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 12),
            child: PlaceCard(isCardSelected: isCardSelected, activityModel: activityModel[index],),
          ),
          itemCount: 6,
        ),
      ),
    );
  }
}
