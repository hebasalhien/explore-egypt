import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/trending/presentation/view/widgets/landmark_details.dart';
import 'package:flutter/material.dart';

class LandmarkDetailsRow extends StatelessWidget {
  const LandmarkDetailsRow({super.key, required this.landmark});

  final LandmarkModel landmark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LandmardDetails(
          type: 'Category',
          data: landmark.category,
          svgIcon: AppConstants.categoryIcon,
        ),
        LandmardDetails(
          type: 'Best Time',
          data: landmark.bestTimeToVisit,
          icon: Icons.query_builder,
        ),
        LandmardDetails(
          type: 'Entry Fee',
          data: landmark.price,
          icon: Icons.confirmation_number_outlined,
        ),
        LandmardDetails(
          type: 'Duration',
          data: landmark.duration,
          icon: Icons.calendar_today_outlined,
        ),
      ],
    );
  }
}