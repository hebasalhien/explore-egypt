import 'dart:ui';
import 'dart:math' as math;
import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ChatBackground extends StatelessWidget {
  const ChatBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Rectangle 39953 (Gradient)
          Positioned(
            left: -17,
            right: -17,
            top: 0,
            bottom: 0,
            child: Transform.scale(
              scaleY: -1,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    transform: GradientRotation((209.61 - 90) * math.pi / 180),
                    colors: [
                      Color(0xFFE3A366),
                      Color(0xFFDC9262),
                      Color(0xFFC25454),
                    ],
                    stops: [0.0132, 0.2734, 0.8428],
                  ),
                ),
              ),
            ),
          ),

          // Background Texture Image (Responsive)
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                AppConstants.bgImage,
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
          ),

          // Frame 1171275584 (Overlay)
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.95, sigmaY: 1.95),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            transform:
                                GradientRotation((160.53 - 90) * math.pi / 180),
                            stops: [0.1401, 0.8329],
                            colors: [
                              Color.fromRGBO(119, 34, 25, 0),
                              Color.fromRGBO(22, 2, 0, 0.39),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
