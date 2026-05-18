import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // We define how far down the paint should go.
    // Setting bottomY to roughly 60% of the height moves the entire paint down a tiny bit.
    final double bottomY = h * 0.60; 
    final double edgeY = h * 0.30;
    
    // Calculate the control point Y so that the peach curve touches exactly `bottomY` at the center.
    // Mathematical property of quadratic bezier: midpoint Y = 0.25*start + 0.5*control + 0.25*end
    final double controlY = 2 * bottomY - edgeY;

    // 1. Draw the orange background (kPrimaryColor)
    // This serves as the base layer for the bottom corners.
    final Paint orangePaint = Paint()
      ..color = AppColors.kPrimaryColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, bottomY), orangePaint);

    // 2. Draw the peach background on top (kPlanPageBgColor)
    final Path peachPath = Path();
    peachPath.moveTo(0, 0);
    peachPath.lineTo(w, 0);
    peachPath.lineTo(w, edgeY);
    
    // Curve down to touch bottomY in the center
    peachPath.quadraticBezierTo(w * 0.5, controlY, 0, edgeY);
    
    peachPath.close();

    final Paint peachPaint = Paint()
      ..color = AppColors.kPlanPageBgColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(peachPath, peachPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
