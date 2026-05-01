import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.pl});
  final double pl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        spacing: 10,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.kWhite,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                'https://as1.ftcdn.net/jpg/03/23/70/30/1000_F_323703039_3cWWw6oi1HfcBbH7XynKIHUTwhRuMLkF.webp',
              ),
            ),
          ),
          Text(
            'Welcome back, test!',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: GoogleFonts.notoSerif().fontFamily,
              color: AppColors.kWhite,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: AppColors.kWhite),
            padding: EdgeInsets.only(left: pl, right: 0),
          ),
        ],
      ),
    );
  }
}
