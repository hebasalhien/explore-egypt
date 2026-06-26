import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandmarkInfoWidget extends StatelessWidget {
  const LandmarkInfoWidget({super.key, required this.landmark});

  final LandmarkModel landmark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'About ${landmark.name}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: Text(
                landmark.description,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textCaption,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xffF8EFE5), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0D000000),
                        offset: Offset(0, 1),
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Column(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(AppConstants.audioGuideIcon),
                      Text(
                        'Audio guide',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.kPrimaryVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}