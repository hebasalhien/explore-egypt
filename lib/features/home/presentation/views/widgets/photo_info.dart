import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  const PhotoInfo({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          subtitle.toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white,
            fontFamily: GoogleFonts.notoSerif().fontFamily,
          ),
        ),
      ],
    );
  }
}

