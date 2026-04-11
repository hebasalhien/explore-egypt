import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String imageURL;
  final String level;
  const UserInfo({
    super.key,
    required this.name,
    required this.imageURL,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: CircleBorder(),
          elevation: 10,
          color: AppColors.kWhite,

          child: CircleAvatar(
            radius: 55,
            backgroundColor: AppColors.kWhite,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(imageURL),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(name, style: Theme.of(context).textTheme.headlineMedium),
        Text(
          'ADVENTURER LEVEL $level',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: AppColors.kPrimaryColor),
        ),
      ],
    );
  }
}