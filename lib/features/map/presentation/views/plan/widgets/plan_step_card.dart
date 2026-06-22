import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PlanStepCard extends StatelessWidget {
  final String time;
  final String cost;
  final String title;
  final String subtitle;
  final String? imageURL;
  const PlanStepCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.time,
    required this.cost,
    required this.title,
    required this.subtitle,
    required this.imageURL,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: screenHeight * .17,
        decoration: BoxDecoration(
          color: AppColors.kBGColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                Text(
                  cost.contains('\$') ? cost : '$cost\$',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.kBlack),
              ),
              subtitle: Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: Color(0xff64748B)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Container(
                width: screenWidth * .16,
                height: screenHeight * .16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image:imageURL!=null?NetworkImage(imageURL!): AssetImage("assets/images/pyramid.png"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
