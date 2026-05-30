import 'package:flutter/material.dart';

class MapButton extends StatelessWidget {
  const MapButton({super.key, this.color, required this.icon, this.onTap});
  final Color? color;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? Color(0xCC2D2D2D),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

