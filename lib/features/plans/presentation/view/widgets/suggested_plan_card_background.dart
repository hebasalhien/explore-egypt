import 'package:flutter/material.dart';

class SuggestedPlanCardBG extends StatelessWidget {
  const SuggestedPlanCardBG({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
        boxShadow: const [
          // Shadow 1 (Larger, softer drop shadow)
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
          // Shadow 2 (Tighter, inner-core shadow)
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
        ],
      ),
    );
  }
}