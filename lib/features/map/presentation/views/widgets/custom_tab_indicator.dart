import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  const CustomTabIndicator();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter();
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final double w = configuration.size?.width ?? 194;
    final double h = configuration.size?.height ?? 48;

    final double bump = 20;
    final double rise = 18;
    final double curve = 16;

    // Symmetric shape — same curve on both sides
    final Path path = Path();
    path.moveTo(offset.dx, offset.dy + h);

    // Left side bump up
    path.cubicTo(
      offset.dx + curve,
      offset.dy + h,
      offset.dx + bump,
      offset.dy + h - rise,
      offset.dx + bump,
      offset.dy + h - rise - 4,
    );
    path.cubicTo(
      offset.dx + bump,
      offset.dy + h - rise - 10,
      offset.dx + bump + 10,
      offset.dy,
      offset.dx + bump + 22,
      offset.dy,
    );

    // Flat top
    path.lineTo(offset.dx + w - bump - 22, offset.dy);

    // Right side bump down (mirror of left)
    path.cubicTo(
      offset.dx + w - bump - 10,
      offset.dy,
      offset.dx + w - bump,
      offset.dy + h - rise - 10,
      offset.dx + w - bump,
      offset.dy + h - rise - 4,
    );
    path.cubicTo(
      offset.dx + w - bump,
      offset.dy + h - rise,
      offset.dx + w - curve,
      offset.dy + h,
      offset.dx + w,
      offset.dy + h,
    );

    path.close();

    // Fill only — no stroke, so no bottom border color
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.fill
        ..color =  AppColors.kPlanPageBgColor,
    );

    // Top + sides border only (clip bottom away)
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(
        offset.dx,
        offset.dy,
        w,
        h - 1, // clip 1px from bottom
      ),
    );
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = AppColors.kSecondary,
    );
    canvas.restore();
  }
}
