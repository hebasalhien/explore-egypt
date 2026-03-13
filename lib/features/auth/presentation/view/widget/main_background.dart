import 'package:explore_egypt/features/widgets/background.dart';
import 'package:explore_egypt/features/widgets/custom_wave_shape.dart';
import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BackGround(),
        CustomWaveShape(),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: child
          ),
        ),
      ],
    );
  }
}
