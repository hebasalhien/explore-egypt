import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/map/model/entities/activity_model.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.isCardSelected,
    required this.activityModel,
    required this.onTap,
  });

  final bool isCardSelected;
  final ActivityModel activityModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: isCardSelected
              ? Border.all(color: AppColors.kSecondary, width: 2)
              : Border.all(color: Color(0xffF3F4F6), width: 2),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: activityModel.image == null
                        ? AssetImage("assets/images/pyramid.png")
                        : NetworkImage(activityModel.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          activityModel.time,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(color: AppColors.kSecondary),
                        ),
                        Text(
                          '${activityModel.cost}\$',
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(color: AppColors.kSecondary),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        activityModel.landmarkName,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      activityModel.description,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Color(0xff6B7280),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
