import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreWidget extends StatelessWidget {
  const ExploreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Where to, Explorer?',
          style: TextStyle(
            fontFamily: GoogleFonts.notoSerif().fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        Icon(Icons.mic_none, color: Color(0xFF9F411E)),
      ],
    );
  }
}

