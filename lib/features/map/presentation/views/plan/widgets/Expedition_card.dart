import 'package:explore_egypt/features/home/presentation/views/widgets/glass_icon_button.dart';
import 'package:explore_egypt/features/map/presentation/views/plan/widgets/card_info.dart';
import 'package:flutter/material.dart';

class ExpeditionCard extends StatelessWidget {
  const ExpeditionCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: screenHeight * .4,
        width: screenWidth * .65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/pyramid.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 8,
              top: 8,
              child: GlassIconButton(),
            ),
            
            Positioned(
              bottom: 10,
              left:0,
              right:0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: CardInfo(screenWidth: screenWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

