import 'package:flutter/material.dart';

class UserPositionMarker extends StatelessWidget {
  const UserPositionMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xCC60A5FA),
      ),
      child: Center(
        child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(width: 1, color: Color(0xff3B82F6)),
          ),
        ),
      ),
    );
  }
}
