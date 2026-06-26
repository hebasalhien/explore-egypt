import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/model/entities/activity_model.dart';
import 'package:flutter/material.dart';

class PlanStepCard extends StatelessWidget {
  const PlanStepCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.activityModel
  });
  final ActivityModel activityModel;
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
                  activityModel.time,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                Text(
                  activityModel.cost.toString().contains('\$') ? activityModel.cost.toString(): '${activityModel.cost.toString()}\$',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ],
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                activityModel.landmarkName,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: AppColors.kBlack),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                activityModel.description,
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
                    image: activityModel.image != null
                        ? NetworkImage(activityModel.image!)
                        : AssetImage("assets/images/pyramid.png"),
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
