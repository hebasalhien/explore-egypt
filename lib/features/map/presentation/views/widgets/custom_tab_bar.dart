import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({super.key, required this.controller});
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.kSecondary, width: 1.5),
          ),
        ),
        child: TabBar(
          controller: controller,
          tabs: [Text('Plan'), Text('Map')],
          labelStyle: Theme.of(context).textTheme.headlineSmall,
          labelPadding: EdgeInsets.only(top: 10),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
