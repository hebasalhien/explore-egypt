import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        leading: icon.isNotEmpty
            ? SvgPicture.asset(icon)
            : const Icon(Icons.logout, color: AppColors.kPrimaryVariant),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.kPrimaryColor,
          size: 16,
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.white,
      ),
    );
  }
}
