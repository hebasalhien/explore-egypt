import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.imageUrl});
  final String? imageUrl;
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
          backgroundImage: const AssetImage(
            AppConstants.userImage,
          ), // ← always shown as fallback
          foregroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
              ? CachedNetworkImageProvider(imageUrl!)
              : null, // Placeholder icon
        ),
      ),
    );
  }
}
