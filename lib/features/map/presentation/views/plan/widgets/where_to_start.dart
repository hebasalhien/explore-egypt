import 'package:explore_egypt/features/map/presentation/views/plan/widgets/Expedition_card.dart';
import 'package:flutter/material.dart';

class WhereToStart extends StatelessWidget {
  const WhereToStart({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            'Not sure where to start?',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Suggested expedition',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(fontSize: 20),
          ),
          SizedBox(
            height: screenHeight * .4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return ExpeditionCard(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

