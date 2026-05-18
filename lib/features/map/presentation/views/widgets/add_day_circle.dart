import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:explore_egypt/core/theme/app_colors.dart';

class AddDayCircle extends StatelessWidget {
  const AddDayCircle({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 50,
            width: 50,
            child: CustomPaint(
              painter: DashedCirclePainter(
                color: AppColors.kGrey,
                strokeWidth: 2.0,
                dashWidth: 6.0,
                dashSpace: 4.0,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 28, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double circumference = 2 * math.pi * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();
    
    // Adjust dashSpace so that the dashes fit perfectly around the circle evenly
    final double adjustedDashSpace = (circumference / dashCount) - dashWidth;

    double currentAngle = 0;
    for (int i = 0; i < dashCount; ++i) {
      final double sweepAngle = (dashWidth / circumference) * 2 * math.pi;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        sweepAngle,
        false,
        paint,
      );
      currentAngle += sweepAngle + (adjustedDashSpace / circumference) * 2 * math.pi;
    }
  }

  @override
  bool shouldRepaint(covariant DashedCirclePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace;
  }
}