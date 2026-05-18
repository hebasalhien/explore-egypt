import 'package:explore_egypt/core/constants/app_constants.dart';
import 'package:explore_egypt/core/theme/app_colors.dart';
import 'package:explore_egypt/features/home/model/entities/active_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NextDestinationWidget extends StatelessWidget {
  const NextDestinationWidget({super.key, required this.activePlanModel});
  final ActivePlanModel activePlanModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'NEXT DESTINATION',
        style: Theme.of(
          context,
        ).textTheme.titleSmall!.copyWith(color: AppColors.kRowActionColor),
      ),
      subtitle: Text(
        activePlanModel.nextDestination,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18),
      ),
      leading: Container(
        width: 50,
        height: 50,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xffEFE0CD),
          borderRadius: BorderRadius.circular(26),
        ),
        child: SvgPicture.asset(
          AppConstants.nextDestinationIcon,
          width: 14,
          height: 14,
        ),
      ),
    );
  }
}