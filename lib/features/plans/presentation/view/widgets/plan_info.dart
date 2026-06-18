import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanInfo extends StatelessWidget {
  const PlanInfo({
    super.key,
    required this.screenWidth,
    required this.title,
    required this.subtitle,
  });

  final double screenWidth;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            subtitle.toUpperCase(),
            style: Theme.of(context).textTheme.titleSmall,
            softWrap: true,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
              fontFamily: GoogleFonts.notoSerif().fontFamily,
            ),
            softWrap: true,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Highlights:',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Color(0xffE8C4A0)),
                ),
                TextSpan(
                  text:
                      'Philae Temple, Karnak, Nile Cruise, Valley of the kings',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

