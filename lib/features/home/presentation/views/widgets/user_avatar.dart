import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CircleAvatar(
        radius: 21,
        backgroundColor: AppColors.kWhite,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
            'https://as1.ftcdn.net/jpg/03/23/70/30/1000_F_323703039_3cWWw6oi1HfcBbH7XynKIHUTwhRuMLkF.webp',
          ),
        ),
      ),
    );
  }
}

