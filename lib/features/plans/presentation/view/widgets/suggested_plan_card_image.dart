import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SuggestedPlanCardImage extends StatelessWidget {
  const SuggestedPlanCardImage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      // 1. This creates the exact CSS 0deg gradient (Bottom to Top)
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.bottomCenter, // 0% mapping
          end: Alignment.topCenter, // 100% mapping
          colors: [
            Color(0xFF000000), // Black at the very bottom (0%)
            Color(0x00000000), // Fully transparent black at 50%
            Color(0x00000000), // Fully transparent black at 100%
          ],
          stops: [0.0, 0.5, 1.0], // Maps exactly to your 0%, 50%, 100%
        ).createShader(bounds);
      },
      // 2. Tells Flutter to blend the gradient on top of the image container
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          color:
              Colors.white, // Maps to your solid white CSS background fallback
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          image: DecorationImage(
            image: CachedNetworkImageProvider(image),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
