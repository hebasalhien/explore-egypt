import 'package:explore_egypt/features/home/presentation/views/widgets/glass_icon_button.dart';
import 'package:explore_egypt/features/home/presentation/views/widgets/photo_info.dart';
import 'package:flutter/material.dart';

class LandmarkCard extends StatelessWidget {
  const LandmarkCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.title,
    required this.subtitle,
    required this.image,
  });
  final String title;
  final String subtitle;
  final String image;
  final double screenHeight;
  final double screenWidth;

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
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Positioned(right: 8, top: 8, child: GlassIconButton()),

            Positioned(
              left: 15,
              bottom: 15,
              child: PhotoInfo(title: title, subtitle: subtitle),
            ),
          ],
        ),
      ),
    );
  }
}

