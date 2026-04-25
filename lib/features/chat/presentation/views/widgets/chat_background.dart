import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ChatBackground extends StatelessWidget {
  const ChatBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AppConstants.bgImage, fit: BoxFit.fill),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight, // ~209deg
              end: Alignment.bottomLeft,
              colors: [
                Color(0xCCE3A366),
                Color(0xCCDC9262),
                Color(0xCCC25454),
              ],
              stops: [0.013, 0.273, 0.842],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight, // ~160deg
              colors: [
                Color.fromRGBO(119, 34, 25, 0),
                Color.fromRGBO(22, 2, 0, 0.39),
              ],
              stops: [0.14, 0.83],
            ),
          ),
        ),
    
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, 0.24),
                Color.fromRGBO(0, 0, 0, 0.24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
