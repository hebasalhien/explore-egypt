import 'package:explore_egypt/features/home/model/entities/landmark_model.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/glass_icon_button.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/photo_info.dart';
import 'package:flutter/material.dart';

class LandmarkCard extends StatelessWidget {
  const LandmarkCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.landmarkModel,
  });

  final double screenHeight;
  final double screenWidth;
  final LandmarkModel landmarkModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: screenHeight * .25,
        width: screenWidth * .45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          image: DecorationImage(
            image: NetworkImage(landmarkModel.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(right: 8, top: 8, child: GlassIconButton()),

            Positioned(
              left: 15,
              bottom: 15,
              child: SizedBox(
                width: screenWidth * .35,
                child: PhotoInfo(
                  title: landmarkModel.name,
                  subtitle: landmarkModel.subtitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
